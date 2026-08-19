# frozen_string_literal: true

# load_defaults 7.2 switches key_generator_hash_digest_class to SHA256, but blob
# URLs already embedded in content fields were signed with SHA1-derived keys and
# would 404. Accept both while signing new ones with SHA256.
Rails.application.config.after_initialize do
  next if Rails.application.secret_key_base.blank?

  old_secret = ActiveSupport::KeyGenerator.new(
    Rails.application.secret_key_base,
    iterations: 1000,
    hash_digest_class: OpenSSL::Digest::SHA1
  ).generate_key("ActiveStorage")

  new_secret = Rails.application.key_generator.generate_key("ActiveStorage")

  verifier = ActiveSupport::MessageVerifier.new(new_secret)
  verifier.rotate(old_secret)

  ActiveStorage::Blob.instance_variable_set(:@signed_id_verifier, verifier)
end
