# frozen_string_literal: true

require "rails_helper"

# We make sure that the checksum of the file overriden is the same
# as the expected. If this test fails, it means that the overriden
# file should be updated to match any change/bug fix introduced in the core
checksums = [
  {
    package: "decidim-admin",
    files: {
      "/app/views/decidim/admin/static_pages/index.html.erb" => "0244901bd7ad503ef24f3a6c6786a84d"
    }
  },
  {
    package: "decidim-forms",
    files: {
      "/app/queries/decidim/forms/questionnaire_user_answers.rb" => "c307cf850ae7790aa4cea2255066ca9d"
    }
  },
  {
    package: "decidim-pages",
    files: {
      "/app/views/decidim/pages/application/show.html.erb" => "69a1ceb1bcb6b241ec68d7c81dcf6551"
    }
  },
  {
    package: "decidim-proposals",
    files: {
      "/app/views/decidim/proposals/proposals/show.html.erb" => "1ced23954b10bcb98da4ef45be66cf85"
    }
  },
  {
    package: "decidim-surveys",
    files: {
      "/app/controllers/decidim/surveys/surveys_controller.rb" => "da8242f88f1d703b5154a57254f48e7a"
    }
  },
  {
    package: "decidim-core",
    files: {
      # views
      "/app/views/decidim/pages/index.html.erb" => "4606c1811c709bd3b81f75aaaf8f830e",

      # layouts
      "/app/views/layouts/decidim/_head_extra.html.erb" => "1b8237357754cf519f4e418135f78440",
      "/app/views/layouts/decidim/_mini_footer.html.erb" => "55a9ca723b65b8d9eadb714818a89bb3",
      "/app/views/layouts/decidim/mailer.html.erb" => "5bbe335c1dfd02f8448af287328a49dc"
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
