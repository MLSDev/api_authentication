class ApiAuthentication::SessionDecorator < Draper::Decorator
  delegate_all

  decorates_association :user, -> { defined?(UserDecorator) ? UserDecorator : ApiAuthentication::UserDecorator }
end
