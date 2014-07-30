#!/usr/bin/env ruby
Dir.chdir('..')
$:.unshift File.dirname(__FILE__)

require 'rubygems'
require 'yaml'
require 'json'
require 'webrick'
require 'logger'
require 'lib/gitlab'
require 'lib/webrick'
require 'lib/hooks'
require 'lib/log'

module Grook

  class << self
      
    attr_reader :gitlab
    attr_reader :server
    
    def init
      url = config["gitlab"]["url"]
      port = config["gitlab"]["port"]
      api_key = config["gitlab"]["api_key"]
      @gitlab = Gitlab::Server.new(url,port,api_key)
      if config["web"]["bind_address"].nil?
        puts "!! Bind address not specified.  Listening on all interfaces..."
      else
	puts sprintf(":: server listening on %s:%d\n",config["web"]["bind_address"],config["web"]["port"])
      end
      @server = WEBrick::HTTPServer.new(:Port => config["web"]["port"],
                                        :BindAddress => config["web"]["bind_address"],
				        :Logger => WEBrick::Log.new(config["web"]["log"]),
					:AccessLog => [ [$stderr, WEBrick::AccessLog::COMMON_LOG_FORMAT],
						        [$stderr, WEBrick::AccessLog::REFERER_LOG_FORMAT] ])
      # create push hooks
      mount_hooks(config["hooks"]["push"],PushHook)
      # create tag push hooks
      mount_hooks(config["hooks"]["tag"],TagHook)
      # create issue hook
      mount_hooks(config["hooks"]["issue"],IssueHook)
      #create merge hook
      mount_hooks(config["hooks"]["merge"],MergeHook)
    end

    def mount_hooks(params,klass)
      params.each do |h|
	Log.add(h["name"],config["hooks"]["log"],h["log_level"])
	@server.mount h["mount"], klass, Log[h["name"]], h["name"], h["path"], h["repo"], h["ref"]
      end
    end

    def config
      YAML.load_file('./config/config.yml')
    end

  end

end

puts ":: grook initializing..."
Grook.init
trap 'INT'  do Grook.server.shutdown end
trap 'SIGTERM' do Grook.server.shutdown end
puts ":: starting server..."
Grook.server.start

