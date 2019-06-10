# frozen_string_literal: true

module ApiAuthentication
  class UserDecorator < Draper::Decorator
    delegate_all

    def as_json(*)
      {
        id: id,
        email: email,
        username: username,
        first_name: first_name,
        last_name: last_name,
        birthday: birthday
      }
    end
  end
end