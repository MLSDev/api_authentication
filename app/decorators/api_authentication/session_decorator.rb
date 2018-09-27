class ApiAuthentication::SessionDecorator < Draper::Decorator
  delegate_all

  decorates_association :user

  def as_json *args
    if defined?(::SessionDecorator)
      ::SessionDecorator.decorate(model, context: context).as_json
    else
      {
        token: token,
        user:  user
      }
    end
  end
end
