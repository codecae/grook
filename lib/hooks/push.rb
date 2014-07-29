module Grook

  class PushHook < JSONHook
    
    def _hook_args
      project = Grook.gitlab.project(@hook_json["project_id"])["name_with_namespace"]
      [ [ @hook_json["before"],
          @hook_json["after"],
          @hook_json["ref"],
          @hook_json["user_name"],
	  project,
	  @hook_json["repository"]["name"],
	  @hook_json["repository"]["url"],
	  @hook_json["total_commits_count"]] ] 
    end

    def _hook_ref
      @hook_json["ref"]
    end

    def _hook_project
      Grook.gitlab.project(@hook_json["project_id"])
    end

  end

end
