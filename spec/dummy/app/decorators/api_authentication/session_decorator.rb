class ApiAuthentication::SessionDecorator < Draper::Decorator
  delegate_all

  decorates_association :user

  def as_json *args
    {
      user:    user,
      session: super(only: :token)
    }
  end
end
