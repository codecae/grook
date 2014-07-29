module Grook

  class Hook < Web::SimpleServlet

    attr_reader :name
    attr_reader :path
 
    def _hook_args(request)
      return []
    end
 
    def _hook_ref
    end

    def _hook_project
    end

    def _hooks
      ((Dir.entries(@path)-[".",".."]).map { |f| @path+'/'+f }).sort    
    end

    def _call
      @log.info { "Hook request received for: \"#{@name}\"" }
      hook_args = _hook_args
      @log.debug { "URL: \"#{@url}\" (config) - \"#{_hook_project["ssh_url_to_repo"]}\" (request)" }
      @log.debug { "REF: \"#{@ref || "n/a"}\" (config) - \"#{_hook_ref || "n/a"}\" (request)" }
      if @url==_hook_project["ssh_url_to_repo"] && @ref==_hook_ref
	hook_args.each do |args|
	  @log.debug { "Processing arguements: \"#{args}\"" }
	  _hooks.each do |hook| 
	    if File.executable_real?(hook) && File.file?(hook)
	      @log.debug { "\"#{hook}\" is an executable file" }
	      script_args=args.map { |a| "\"#{a.to_s.gsub(/"/,"'")}\"" }
	      @log.info { "Calling: #{hook} #{script_args.join(" ")}" }
	      %x( #{hook} #{script_args.join(" ")} )
	    else
	      @log.warn { "Cannot call #{hook}.  Check file permissions." }
	    end
	  end
	end
      else
	@log.warn { "\"#{@name}\" hook skipped!" }
	@log.warn { "SSH URL on an incoming hook does not match configuration - #{@url || "<Unspecified>" } (config.yml) != #{_hook_project["ssh_url_to_repo"] || "<Unspecified>"} (gitlab)" } unless @url==_hook_project["ssh_url_to_repo"]
	@log.warn { "Git REF on an incoming hook does not match configuration - #{@ref || "<Unspecified>" } (config.yml) != #{_hook_ref || "<Unspecified>"} (gitlab)" } unless @ref==_hook_ref
      end
    end

    def _get(request)
      super request
    end;

    def _post(request)
      super request
    end;

    def initialize(server,log,*args)
      super server
      @log = log
      @name = args[0]
      @path = args[1]
      @url = args[2]
      @ref = args[3]
      @log.debug { "Created Hook: \"#{@name}\"" }
      @log.debug { " - Path: #{@path}" }
      @log.debug { " - URL: #{@url}" }
      @log.debug { " - Ref: #{@ref}" }
    end

  end

end
