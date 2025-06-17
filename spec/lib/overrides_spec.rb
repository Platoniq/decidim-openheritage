# frozen_string_literal: true

require "rails_helper"

# We make sure that the checksum of the file overriden is the same
# as the expected. If this test fails, it means that the overriden
# file should be updated to match any change/bug fix introduced in the core
checksums = [
  {
    package: "decidim-admin",
    files: {
      "/app/views/decidim/admin/static_pages/index.html.erb" => "debf4d3ae461c4c827f8e3242c6e8727"
    }
  },
  {
    package: "decidim-conferences",
    files: {
      "/app/views/decidim/conferences/conferences/_conference_hero.html.erb" => "da4e86d29cf4272356d4bed6130d641f",
      "/app/views/decidim/conferences/conferences/show.html.erb" => "f473d522ddc4c5f3352f3fc55cffdd7d"
    }
  },
  {
    package: "decidim-forms",
    files: {
      "/app/queries/decidim/forms/questionnaire_user_answers.rb" => "fb14ed5f570c6d18e5d0d83808d03b5d",
      "/app/commands/decidim/forms/answer_questionnaire.rb" => "b4e2523cadbcb16f827c4b3cefa03a98"
    }
  },
  {
    package: "decidim-participatory_processes",
    files: {
      "/app/models/decidim/participatory_process.rb" => "6f19ab033d83404a6f314911b7538fbf"
    }
  },
  {
    package: "decidim-proposals",
    files: {
      "/app/views/decidim/proposals/proposals/show.html.erb" => "ec5980ab50a4999b2a6975e61998ec1f"
    }
  },
  {
    package: "decidim-surveys",
    files: {
      "/app/controllers/decidim/surveys/surveys_controller.rb" => "161ca4167c381f3ba93d86431c10710b"
    }
  },
  {
    package: "decidim-core",
    files: {
      # footer
      "/app/views/layouts/decidim/footer/_mini.html.erb" => "ccead2f5f20557ea4db1501de943f82b",

      # views
      "/app/views/decidim/pages/index.html.erb" => "b84cdfb13960c465e082adfee3a68d8c",

      # layouts
      "/app/views/layouts/decidim/_head_extra.html.erb" => "25642b423f3b3a1ac9c69bf558a6b791",
      "/app/views/layouts/decidim/mailer.html.erb" => "23a555f9c674d7db4b0ea6582525e2d6",
      "/app/views/devise/mailer/invite_private_user.html.erb" => "f978eddb05fa55af2c33ce78c964a2bb"
    }
  }
]

describe "Overriden files", type: :view do
  checksums.each do |item|
    spec = Gem::Specification.find_by_name(item[:package])
    item[:files].each do |file, signature|
      it "#{spec.gem_dir}#{file} matches checksum" do
        expect(md5("#{spec.gem_dir}#{file}")).to eq(signature)
      end
    end
  end

  private

  def md5(file)
    Digest::MD5.hexdigest(File.read(file))
  end
end
