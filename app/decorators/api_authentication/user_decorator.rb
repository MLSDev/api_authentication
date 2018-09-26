class ApiAuthentication::UserDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    {
      id: id
    }
  end
end
