class ApiAuthentication::UserDecorator < ( defined?(::UserDecorator) ? ::UserDecorator : Draper::Decorator )
  delegate_all

  def as_json *args
    if defined?(::UserDecorator)
      super
    else
      {
        id: id
      }
    end
  end
end
