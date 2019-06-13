# frozen_string_literal: true

require 'rails_helper'

describe ApiAuthentication::SocialProviders::Facebook do
  describe '#fetch_data' do
    context 'return user data' do
      let(:access_token) do
        'EAATNbOL45KkBAAGKdGYTjgjyJ3y75jKAZAhAZCBhgL659bYsNHAabSc4HCyQe'\
        'AXZAF5uWgfOtylAuYAIvZCgj7ZAxDwhFAqZCSroCZChxDjosM3S1kqu2Lg8FAqGblWXb5bGI9'\
        'JvhpjfgywVDnFblIu9M2U3d5ZCYiioE6VLszIfLkIQHHU3nszQliqj8nDE7v8ds3nrLGzmWQZDZD'
      end

      subject { described_class.new(access_token) }

      before { VCR.insert_cassette 'facebook/me_success' }

      it do
        user_data = subject.fetch_data

        expect(user_data[:id]).to eq '118777242377720'
        expect(user_data[:email]).to eq 'open@graph.com'
        expect(user_data[:first_name]).to eq 'Open'
        expect(user_data[:last_name]).to eq 'User'
        expect(user_data[:username]).to eq 'Open Graph Test User'
        expect(user_data[:birthday]).to eq nil
        expect(user_data[:avatar]).to eq 'https://platform-lookaside.fbsbx.com/platform/profilepic/'\
        '?asid=118777242377720&height=300&width=300&ext=1560697844&hash=AeRpefeAIAKYbriL'
      end

      after { VCR.eject_cassette }
    end

    context 'raise error' do
      subject { described_class.new('token') }

      before { VCR.insert_cassette 'facebook/me_error' }

      it do
        expect { subject.fetch_data }.to raise_error ApiAuthentication::Auth::FacebookError
      end

      after { VCR.eject_cassette }
    end
  end
end
