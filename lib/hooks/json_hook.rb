module Grook

  class JSONHook < Hook
    
    def _post(request)
      @hook_json = JSON.parse(request.body)
      @log.debug { "\"#{@name}\" hook called" }
      @log.debug { " - Request body: \"#{request.body}\"" }
      @log.debug { " - Parsed JSON: \n\"#{JSON.pretty_generate(@hook_json)}\"" }
      super _call
      return 200, 'text/plain', 'Merge Hook Recieved'
    end

  end

end
