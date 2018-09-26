class ApiAuthentication::Social::FacebookLoginService
  attr_reader :access_token

  def initialize access_token
    @access_token = access_token
  end

  def user
    return unless response

    return @user if @user

    @user = existing_user || ApiAuthentication::User.created_via_social_login.new(
      email:       email,
      password:    password,
      facebook_id: response['id']
    ).tap do |user|
      user.username = response['name'] if ApiAuthentication.configuration.pull_variables_from_facebook.include?("username")
      user.first_name = response['first_name'] if ApiAuthentication.configuration.pull_variables_from_facebook.include?("first_name")
      user.last_name = response['last_name'] if ApiAuthentication.configuration.pull_variables_from_facebook.include?("last_name")
      user.avatar = avatar if ApiAuthentication.configuration.pull_variables_from_facebook.include?("avatar")
      user.full_name = response['name'] if ApiAuthentication.configuration.pull_variables_from_facebook.include?("full_name")
      user.birthday = response['birthday'] if ApiAuthentication.configuration.pull_variables_from_facebook.include?("birthday")
    end

    binding.pry

    @user
  end

  def existing_user
    return @existing_user if @existing_user

    @existing_user = ApiAuthentication::User.find_by_facebook_id(response['id']) || ApiAuthentication::User.find_by_email(response['email'])

    @existing_user.update_column :facebook_id, response['id'] if @existing_user

    @existing_user
  end

  def error_response
    response['error']['message'].presence if response['error']
  rescue
    nil
  end

  def valid?
    [access_token, response, error_response.nil?].all?
  end

  private

  def response
    binding.pry
    @response ||= JSON.parse(Net::HTTP.get(url))
  rescue
    nil
  end

  def url
    @url ||= URI "https://graph.facebook.com/me?access_token=#{ access_token }&fields=id,email,birthday,name,first_name,last_name,picture.width(300).height(300)"
  end

  def avatar
    response['picture']['data']['url']
  end

  def password
    SecureRandom.uuid
  end

  def email
    response['email']
  end
end
