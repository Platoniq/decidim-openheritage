# frozen_string_literal: true

require "rails_helper"

# We make sure that the checksum of the file overriden is the same
# as the expected. If this test fails, it means that the overriden
# file should be updated to match any change/bug fix introduced in the core
checksums = [
  {
    package: "decidim-admin",
    files: {
      "/app/views/decidim/admin/static_pages/index.html.erb" => "962d13c4af3ab0767ea467f6ef8b64b0"
    }
  },
  {
    package: "decidim-conferences",
    files: {
      "/app/views/layouts/decidim/_conference_hero.html.erb" => "db2e565169a5ce7f8a3e7d03dd0ebfd9",
      "/app/views/decidim/conferences/conferences/show.html.erb" => "94e3fb8ee4e092678ce0f229c87e1bc0"
    }
  },
  {
    package: "decidim-forms",
    files: {
      "/app/queries/decidim/forms/questionnaire_user_answers.rb" => "fb14ed5f570c6d18e5d0d83808d03b5d",
      "/app/commands/decidim/forms/answer_questionnaire.rb" => "c53587b220467c2d6889f657ac2404a0"
    }
  },
  {
    package: "decidim-pages",
    files: {
      "/app/views/decidim/pages/application/show.html.erb" => "f82d74ebe8850f1bd7fe73209a1a1917"
    }
  },
  {
    package: "decidim-participatory_processes",
    files: {
      "/app/models/decidim/participatory_process.rb" => "46c871ef5eb357768c97b3dbc69514a0"
    }
  },
  {
    package: "decidim-proposals",
    files: {
      "/app/views/decidim/proposals/proposals/show.html.erb" => "f27bbec257eb6da28dbdd07ac0a224a5"
    }
  },
  {
    package: "decidim-surveys",
    files: {
      "/app/controllers/decidim/surveys/surveys_controller.rb" => "f443ed19838d251fd9d9b960e5908418"
    }
  },
  {
    package: "decidim-core",
    files: {
      # views
      "/app/views/decidim/pages/index.html.erb" => "4606c1811c709bd3b81f75aaaf8f830e",

      # layouts
      "/app/views/layouts/decidim/_head_extra.html.erb" => "1b8237357754cf519f4e418135f78440",
      "/app/views/layouts/decidim/_mini_footer.html.erb" => "5a842f3e880f24f49789ee2f72d96f60",
      "/app/views/layouts/decidim/mailer.html.erb" => "0c7804de08649c8d3c55c117005e51c9"
    }
  }
]

describe "Overriden files", type: :view do
  checksums.each do |item|
    # rubocop:disable Rails/DynamicFindBy
    spec = ::Gem::Specification.find_by_name(item[:package])
    # rubocop:enable Rails/DynamicFindBy
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
