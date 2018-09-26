class ApiAuthentication::User < ApiAuthentication::ApplicationRecord
  self.table_name = ApiAuthentication.configuration.users_table_name

  has_secure_password

  enum created_via: [
    :created_via_email_login,
    :created_via_social_login,
    :created_via_backoffice_creation
  ]

  has_one :latest_session, -> { order created_at: :desc }, class_name: 'ApiAuthentication::Session'

  has_many :sessions, class_name: 'ApiAuthentication::Session', dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true
  validates :password, length: { minimum: 6 }, allow_nil: true
  # validates :created_via, presence: true

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' },
                             default_url: '/images/:style/missing_avatar.png'

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  before_create :start_new_session

  def update_online_status!
    self.online = sessions.online.exists?

    save!(validate: false) if online_changed?
  end

  def start_new_session
    sessions.system_login.build if created_via_email_login?
  end
end
