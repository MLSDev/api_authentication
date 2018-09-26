class ApiAuthentication::SessionDecorator  < ( defined?(::SessionDecorator) ? ::SessionDecorator : Draper::Decorator )
  delegate_all

  decorates_association :user

  def as_json *args
    {
      token: token,
      user:  user
    }
  end
end
