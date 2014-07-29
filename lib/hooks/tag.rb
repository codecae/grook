module Grook

  class TagHook < JSONHook
    
    def _hook_args
      project = Grook.gitlab.project(@hook_json["project_id"])["name_with_namespace"]
      [ [ @hook_json["before"],
          @hook_json["after"],
          @hook_json["ref"],
          @hook_json["user_name"],
	  project,
	  @hook_json["repository"]["name"],
	  @hook_json["repository"]["url"]] ] 
    end

    def _hook_project
      Grook.gitlab.project(@hook_json["project_id"])
    end

  end

end
