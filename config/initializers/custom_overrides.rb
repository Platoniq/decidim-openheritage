# frozen_string_literal: true
# Add images to proposals cars
#

Rails.application.config.to_prepare do

  #hide buttons if no next
  Decidim::Proposals::ProposalMCell.class_eval do
    def has_image?
      model.photos.any?
    end

    def resource_image_path
      model.photos.first.thumbnail_url
    end
  end
end