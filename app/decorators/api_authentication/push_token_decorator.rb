# frozen_string_literal: true

module ApiAuthentication
  class PushTokenDecorator < Draper::Decorator
    delegate_all

    def as_json(*)
      {
        id: id,
        token: token,
        device_type: device_type
      }
    end
  end
end
