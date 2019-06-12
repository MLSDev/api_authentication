# frozen_string_literal: true

shared_examples 'updating_existing_user_from_fb' do
  it 'changes only facebook_id' do
    expect(ApiAuthentication::SocialProviders::Facebook).to(
      receive_message_chain(:new, :fetch_data)
        .with(access_token)
        .with(no_args)
        .and_return(provider_data),
    )
    old_email = user.email

    subject.save!
    user.reload

    expect(user.facebook_id).to eq provider_data[:id]
    expect(user.email).to eq old_email
    expect(user.first_name).to_not eq provider_data[:first_name]
    expect(user.last_name).to_not eq provider_data[:last_name]
    expect(user.username).to_not eq provider_data[:username]
    expect(user.birthday).to_not eq provider_data[:birthday]
  end
end
