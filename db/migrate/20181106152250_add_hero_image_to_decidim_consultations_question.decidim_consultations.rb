# frozen_string_literal: true

# This migration comes from decidim_consultations (originally 20180202050920)

class AddHeroImageToDecidimConsultationsQuestion < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_consultations_questions, :hero_image, :string
    remove_column :decidim_consultations_questions, :introductory_video_url, :string
  end
end
