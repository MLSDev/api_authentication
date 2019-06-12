# frozen_string_literal: true

require 'rails_helper'

describe ApiAuthentication::SocialLogin do
  describe '#save!' do
    context 'facebook' do
      let(:access_token) { SecureRandom.hex(5) }
      let(:facebook_id) { SecureRandom.hex(5) }
      let(:birthday) { Date.current - 18.years }

      subject { described_class.new(provider: :facebook, access_token: access_token) }

      context 'existing user' do
        context 'update only facebook_id field' do
          context 'for user found by facebook_id' do
            let(:user) { create(:user, facebook_id: facebook_id, birthday: birthday) }
            let(:provider_data) do
              {
                id: facebook_id,
                email: FFaker::Internet.email,
                first_name: FFaker::Name.first_name,
                last_name: FFaker::Name.last_name,
                username: FFaker::Internet.user_name,
                birthday: Date.current
              }
            end

            it_behaves_like 'updating_existing_user_from_fb'
          end

          context 'for user found by email' do
            let(:user) { create(:user, birthday: birthday) }
            let(:provider_data) do
              {
                id: facebook_id,
                email: user.email,
                first_name: FFaker::Name.first_name,
                last_name: FFaker::Name.last_name,
                username: FFaker::Internet.user_name,
                birthday: Date.current,
                avatar: FFaker::Image.url
              }
            end

            it_behaves_like 'updating_existing_user_from_fb'
          end
        end
      end

      context 'new user' do
        let(:provider_data) do
          {
            id: facebook_id,
            email: FFaker::Internet.email,
            first_name: FFaker::Name.first_name,
            last_name: FFaker::Name.last_name,
            username: FFaker::Internet.user_name,
            birthday: Date.current
          }
        end

        it 'updates all user fields' do
          expect(ApiAuthentication::SocialProviders::Facebook).to(
            receive_message_chain(:new, :fetch_data)
              .with(access_token)
              .with(no_args)
              .and_return(provider_data),
          )

          subject.save!

          expect(subject.user.facebook_id).to eq provider_data[:id]
          expect(subject.user.email).to eq provider_data[:email]
          expect(subject.user.first_name).to eq provider_data[:first_name]
          expect(subject.user.last_name).to eq provider_data[:last_name]
          expect(subject.user.username).to eq provider_data[:username]
          expect(subject.user.birthday).to eq provider_data[:birthday]
        end
      end
    end
  end
end
