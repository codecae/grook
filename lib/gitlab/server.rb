module Grook

  module Gitlab

    require 'lib/gitlab/api'

    class Server < Struct.new(:uri,:port,:api_key)
       
      def initialize(uri,port,api_key)
	self.uri = uri
	self.port = port
	self.api_key = api_key
	@userAPI = Grook::Gitlab::UserAPI.new
	@projectAPI = Grook::Gitlab::ProjectAPI.new
      end

      def user(user_id)
	@userAPI.user(self,user_id.to_s)
      end      

      def users
	@userAPI.users(self)
      end

      def project(project_id)
	@projectAPI.project(self,project_id.to_s)
      end

      def projects
	@projectAPI.projects(self)
      end

    end

  end

end
