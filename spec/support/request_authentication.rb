# frozen_string_literal: true

module RequestAuthentication
  def sign_in(user, controller)
    allow_any_instance_of(controller).to receive(:authenticate!).and_return user
    allow_any_instance_of(controller).to receive(:current_user).and_return user
    allow_any_instance_of(controller).to receive(:current_token).and_return 'token'
  end
end
