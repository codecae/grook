module Grook

  class IssueHook < JSONHook
    
    def _hook_args
      if @hook_json["object_attributes"]["assignee_id"].nil?
	@log.debug { "Assignee is unspecified" }
	assignee = "<Unspecified>"
      else
	gitlab_assignee=Grook.gitlab.user(@hook_json["object_attributes"]["assignee_id"])
	@log.debug { "Assignee: \"#{gitlab_assignee}\"" }
	assignee ||= gitlab_assignee["name"]
	@log.debug { "Assignee Name: \"#{assignee}\"" }
      end
      author = Grook.gitlab.user(@hook_json["object_attributes"]["author_id"])["name"]
      project = Grook.gitlab.project(@hook_json["object_attributes"]["project_id"])["name_with_namespace"]
      [	[ @hook_json["object_attributes"]["title"],
	  @hook_json["object_attributes"]["description"],
	  assignee,
	  author,
	  project,
	  @hook_json["object_attributes"]["state"] ] ]
    end

    def _hook_project
      Grook.gitlab.project(@hook_json["object_attributes"]["project_id"])
    end

  end

end
