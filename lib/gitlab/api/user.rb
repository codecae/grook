module Grook

  module Gitlab

    class UserAPI < Grook::Gitlab::API   

      def initialize
	@paths = {:single=>'/users/:id', 
		  :all=>'/users'}
	super @paths
      end

      def user(server,user_id)
	url = _get_url(server,:single).gsub(/:id/,user_id)
	request(url, server.api_key)	
      end

      def users(server)
	url = _get_url(server,:all)
	request(url, server.api_key)
      end

    end

  end

end
