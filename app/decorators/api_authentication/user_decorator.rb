class ApiAuthentication::UserDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    if defined?(::UserDecorator)
      ::UserDecorator.decorate(model, context: context).as_json
    else
      {
        id: id
      }
    end
  end
end
