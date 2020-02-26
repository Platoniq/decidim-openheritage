module ApplicationHelper
	def get_matomo_id
		return unless matomo = Rails.application.secrets.matomo
		id = matomo[:tenants][current_organization&.host.to_sym] if matomo[:tenants].present?
		id || matomo[:id]
	end

	def is_openheritage
		return false unless oh = Rails.application.secrets.openheritage
		oh.include? current_organization&.host.to_str
	end

	def timetracker_survey
		return unless timetracker = Rails.application.secrets.timetracker
		return unless timetracker[:components].respond_to? :include?
		return unless defined? current_component
		return unless timetracker[:components].include? current_component&.id

		Decidim::Surveys::Survey.find_by(component: current_component)
	end
end
