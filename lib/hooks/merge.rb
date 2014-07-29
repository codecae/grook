module Grook

  class MergeHook < JSONHook
    
    def _hook_args
      if @hook_json["object_attributes"]["assignee_id"].nil?
	@log.debug { "Assignee is unspecified" }
        assignee = "<Unspecified>"
      else
        gitlab_assignee=Grook.gitlab.user(@hook_json["object_attributes"]["assignee_id"])
	@log.debug { "Assignee: \"#{gitlab_assignee}\"" }
        assignee ||= gitlab_assignee["name"]
	@log.debug { "Assignee name: \"#{assignee}\"" }
      end
      target_project = Grook.gitlab.project(@hook_json["object_attributes"]["target_project_id"])["name_with_namespace"]
      source_project = Grook.gitlab.project(@hook_json["object_attributes"]["source_project_id"])["name_with_namespace"]
      author = Grook.gitlab.user(@hook_json["object_attributes"]["author_id"])["name"]
      [	[ @hook_json["object_attributes"]["title"],
	  @hook_json["object_attributes"]["description"],
	  @hook_json["object_attributes"]["target_branch"],
	  @hook_json["object_attributes"]["source_branch"],  
	  target_project,
	  source_project,
	  assignee,
	  author,
	  @hook_json["object_attributes"]["state"],
	  @hook_json["object_attributes"]["merge_status"] ] ]
    end

    def _hook_project
      Grook.gitlab.project(@hook_json["object_attributes"]["target_project_id"])
    end

  end

end
