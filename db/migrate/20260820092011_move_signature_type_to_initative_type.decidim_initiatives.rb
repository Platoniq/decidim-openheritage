# frozen_string_literal: true

# This migration comes from decidim_initiatives (originally 20191002082220)
class MoveSignatureTypeToInitativeType < ActiveRecord::Migration[5.2]
  class InitiativesType < ApplicationRecord
    self.table_name = :decidim_initiatives_types
  end

  def change
    if !ActiveRecord::Base.connection.table_exists?("decidim_initiatives_types")
      Rails.logger.info "Skipping migration since there is no InitiativesType table"
      return
    end

    # This flag says when mixed and face-to-face voting methods
    # are allowed. If set to false, only online voting will be
    # allowed.
    #
    # Decidim raises here until this is answered. Set to false: this install has
    # one initiative type ("Free speech") with online_signature_enabled, and no
    # initiatives at all, so online-only preserves exactly the current capability
    # rather than granting face-to-face collection nobody configured. Change it in
    # the admin UI if offline signatures are ever wanted.
    face_to_face_voting_allowed = false

    add_column :decidim_initiatives_types, :signature_type, :integer, null: false, default: 0

    InitiativesType.reset_column_information

    InitiativesType.find_each do |type|
      # The InitiativesType defined at the top of this migration is a bare
      # ApplicationRecord with no enum, so under Rails 7.2 a symbol casts to NULL on
      # this integer column and save! fails the not-null constraint. Assign the enum's
      # integer values directly - Decidim::InitiativesType declares
      # `enum :signature_type, [:online, :offline, :any]`, so online=0, offline=1, any=2.
      type.signature_type = if type.online_signature_enabled && face_to_face_voting_allowed
                              2 # :any
                            elsif type.online_signature_enabled && !face_to_face_voting_allowed
                              0 # :online
                            else
                              1 # :offline
                            end
      type.save!
    end

    remove_column :decidim_initiatives_types, :online_signature_enabled
  end
end
