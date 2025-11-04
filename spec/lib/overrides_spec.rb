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
      "/app/views/decidim/conferences/conferences/show.html.erb" => "441608dc88131043a6fcaca81edc18d1"
    }
  },
  {
    package: "decidim-forms",
    files: {
      "/app/queries/decidim/forms/questionnaire_user_answers.rb" => "0036e31fa16df5c13bc36090bfbad17d",
      "/app/commands/decidim/forms/answer_questionnaire.rb" => "3d6bb923b7146bd0dd0be79f1ecc5f3b"
    }
  },
  {
    package: "decidim-participatory_processes",
    files: {
      "/app/models/decidim/participatory_process.rb" => "eb5c7945d1090f1bda8999ce37b5ecc2"
    }
  },
  {
    package: "decidim-proposals",
    files: {
      "/app/views/decidim/proposals/proposals/show.html.erb" => "4647b22f8414ad5c60b5f4c3b48716c5"
    }
  },
  {
    package: "decidim-surveys",
    files: {
      "/app/controllers/decidim/surveys/surveys_controller.rb" => "5da988772bbe4236f803325e72c9d54f"
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
