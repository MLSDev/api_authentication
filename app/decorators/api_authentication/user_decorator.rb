class ApiAuthentication::UserDecorator < Draper::Decorator
  delegate_all

  decorates_association :user, -> { defined?(UserDecorator) ? UserDecorator : ApiAuthentication::UserDecorator }

  def as_json *args
    {
      token: token,
      user:  user
    }
  end
end
