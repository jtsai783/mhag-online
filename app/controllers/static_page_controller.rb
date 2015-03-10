class StaticPageController < ApplicationController

	def index
		@active_skills = ActiveSkill.select("active_skills.id, active_skills.name, active_skills.skill_id, active_skills.points").where('points > 0').to_json.html_safe
		@active_skills.gsub("'", %q(\\\'))

		@skills = Skill.select("skills.id, skills.name").to_json.html_safe
		render :root
	end
end
