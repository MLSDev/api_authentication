class ApiAuthentication::SessionDecorator  < ( defined?(::SessionDecorator) ? ::SessionDecorator : Draper::Decorator )
  delegate_all

  decorates_association :user

  def as_json *args
    if defined?(::UserDecorator)
      super
    else
      {
        token: token,
        user:  user
      }
    end
  end
end
