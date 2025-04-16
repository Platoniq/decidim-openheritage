# frozen_string_literal: true

Devise.setup do |config|
  # ==> Configuration for :timeoutable
  # The time you want to timeout the user session without activity. After this
  # time the user will be asked for credentials again. Default is 30 minutes.
  config.timeout_in = 2.hours

  # ==> Configuration for :invitable
  # The period the generated invitation token is valid, after
  # this period, the invited resource will not be able to accept the invitation.
  # When invite_for is 0 (the default), the invitation will not expire.
  config.invite_for = 3.weeks
end
