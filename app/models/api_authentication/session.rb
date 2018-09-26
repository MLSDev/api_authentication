class ApiAuthentication::Session < ApiAuthentication::ApplicationRecord
  require 'jwt'

  self.table_name = 'api_authentication_sessions'

  attribute :email
  attr_accessor :password
  attr_accessor :access_token

  enum kind: [:system_login, :email_login, :social_login]

  enum social_login_provider: [:facebook, :twitter, :instagram, :google_plus]

  belongs_to :user,           optional: true, class_name: 'ApiAuthentication::User', autosave: true
  belongs_to :user_via_email, optional: true, class_name: 'ApiAuthentication::User', foreign_key: :email, primary_key: :email

  scope :with_push_token, -> { where.not push_token: nil }
  scope :online,          -> { where online: true }

  validates :kind,                     presence: true
  validates :password,                 presence: true, on: :create, if: :email_login?
  validates :email,                    presence: true, on: :create, if: :email_login?
  validates :access_token,             presence: true, on: :create, if: :social_login?
  validates :access_token_secret,      presence: true, on: :create, if: :twitter?     # :tada:
  validates :social_login_provider,    presence: true, on: :create, if: :social_login?

  validate :password_is_valid,                         on: :create, if: :email_login?
  validate :user_via_email_exists,                     on: :create, if: :email_login?
  validate :social_login_is_valid,                     on: :create, if: :social_login?

  before_create :assign_user,                                       if: :email_login?
  before_validation :assign_or_create_new_user,        on: :create, if: :social_login?

  before_create :generate_unique_secure_token

  def online!
    update! online: true
  end

  def offline!
    update! online: false
  end

  private

  def assign_user
    self.user ||= user_via_email
  end

  def assign_or_create_new_user
    self.user ||= login_service.user
  end

  def user_via_email_exists
    errors.add :base, 'Email and/or password is invalid' unless user_via_email
  end

  def password_is_valid
    return unless user_via_email

    errors.add :base, 'Email and/or password is invalid' unless user_via_email.authenticate(password)
  end

  def social_login_is_valid
    errors.add :base, login_service.error_response unless login_service.valid?
  end

  def login_service
    @login_service ||= ApiAuthentication::Social::LoginService.new self
  end

  #
  # NOTE: now, the `token` column will contain additional information
  #
  def generate_unique_secure_token
    return unless user_id

    self.token ||= ::JWT.encode(
      {
        user: {
          id:               user_id,
          created_at:       Time.now.utc.iso8601(3)
        }
      },
      ENV['JWT_HMAC_SECRET'],
      'HS256'
    )
  end
end

