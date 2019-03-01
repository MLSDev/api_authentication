# frozen_string_literal: true

module ApiAuthentication
  class User < ApplicationRecord
    self.table_name = ApiAuthentication.configuration.users_table_name

    has_secure_password

    has_one :latest_session, -> { order created_at: :desc }, class_name: ApiAuthentication::Session.name

    has_many :sessions, class_name: ApiAuthentication::Session.name, dependent: :destroy

    validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true
    validates :password, length: { minimum: 6 }, allow_nil: true

    enum created_via: {
      created_via_email_login: 0,
      created_via_social_login: 1,
      created_via_backoffice_creation: 2,
    }

    # before_create :start_new_session

    def update_online_status!
      self.online = sessions.online.exists?

      save!(validate: false) if online_changed?
    end

    # def start_new_session
    #   sessions.system_login.build if created_via_email_login?
    # end
  end
end
