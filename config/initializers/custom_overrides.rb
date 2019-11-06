# frozen_string_literal: true
# Add images to proposals cars
#

Rails.application.config.to_prepare do

  # Show images in proposals if they have galleries
  Decidim::Proposals::ProposalMCell.class_eval do
    def has_image?
      model.photos.any?
    end

    def resource_image_path
      model.photos.first.thumbnail_url
    end
  end

  # Parse markdown content if official proposals
  Decidim::Proposals::ProposalPresenter.class_eval do
    def body(links: false, extras: true, strip_tags: false)
      text = proposal.body
      text = strip_tags(text) if strip_tags

      renderer = Decidim::ContentRenderers::HashtagRenderer.new(text)
      text = renderer.render(links: links, extras: extras).html_safe

      if proposal.try(:official?)
        text = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true).render(text)
      else
        text = Decidim::ContentRenderers::LinkRenderer.new(text).render if links
      end

      text
    end
  end
end