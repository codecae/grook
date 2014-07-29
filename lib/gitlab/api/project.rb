module Grook

  module Gitlab

    class ProjectAPI < Grook::Gitlab::API   

      def initialize
	@paths = {:single=>'/projects/:id', 
		  :all=>'/projects/all'}
	super @paths
      end

      def project(server,user_id)
	url = _get_url(server,:single).gsub(/:id/,user_id)
	request(url, server.api_key)	
      end

      def projects(server)
	url = _get_url(server,:all)
	request(url, server.api_key)
      end

    end

  end

end
