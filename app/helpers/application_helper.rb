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
end
