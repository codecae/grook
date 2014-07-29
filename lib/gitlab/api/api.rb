module Grook

  module Gitlab

    class API

      private

      def _get_url(server,path_key)
        server.uri + @paths[path_key]
	#sprintf("%s:%d:%s",server.uri,server.port,@paths[path_key])
      end

      public      

      def initialize(paths)
	@paths=paths
	@paths.each { |key,val| @paths[key]='/api/v3'+val }
      end      

      def request(url, api_key)
	url = url + '?private_token=' + api_key
	uri = URI.parse(url)
	resp = Net::HTTP.get_response(uri)
	JSON.parse(resp.body)
      end

    end

  end

end
