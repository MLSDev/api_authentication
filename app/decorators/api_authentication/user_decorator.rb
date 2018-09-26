class ApiAuthentication::UserDecorator < ( defined?(UserDecorator) ? UserDecorator : Draper::Decorator )
  delegate_all

  def as_json *args
    {
      id: id
    }
  end
end
