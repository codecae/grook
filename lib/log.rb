module Grook

  module Log

    require 'logger'

    class << self

      def add(name,path,threshold)
        @logs={} if @logs.nil?
        @logs[name] = Logger.new(path,10,1024000)
        @logs[name].datetime_format = "%Y-%m-%d %H:%M:%S"
	@logs[name].level = Logger::INFO # default
	@logs[name].level = Logger::DEBUG if threshold=="DEBUG"
	@logs[name].level = Logger::WARN if threshold=="WARN"
	@logs[name].level = Logger::ERROR if threshold=="ERROR"
	@logs[name].level = Logger::FATAL if threshold=="FATAL"
	@logs[name].formatter = proc do |severity,datetime,progname,msg|
	  prefix = ":: INFO ::" # default
	  prefix = ":: DEBUG ::" if severity == "DEBUG"
	  prefix = ":! WARN !:" if severity == "WARN"
	  prefix = "!! ERROR !!" if severity == "ERROR"
	  prefix = "!!!FATAL!!!" if severity == "FATAL"
	  "[ #{prefix} - #{datetime} ] :: #{msg}\n"
	end
      end 

      def [] (key)
	@logs = {} if @logs.nil?
	@logs[key]
      end

      def []= (key,val)
	@logs = {} if @logs.nil?
	@logs[key] = val
      end

    end

  end

end
