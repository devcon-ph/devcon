require 'spec_helper'

feature 'Omniauth' do

  context "facebook login" do
    background do
      @user = Fabricate(:user)
      omniauth_mock('facebook', @user.email, @user.name)
    end

    scenario "sign in a user" do
      omniauth_signin
      expect(page).to have_content(I18n.t "devise.omniauth_callbacks.success", :kind => 'facebook')
    end

    scenario "sign in a user with provider that doesn't exist" do
      new_user = Fabricate(:user, :email => "sample@example123.com", :name => "sample")
      omniauth_mock('facebook', new_user.email, new_user.name)
      omniauth_signin
      expect(page).to have_content(I18n.t "devise.omniauth_callbacks.success", :kind => 'facebook')
    end

    scenario "register a new user" do
      omniauth_mock('facebook', '', '')
      omniauth_signin
      expect(page).to have_content('Registrations are not open yet, but please check back soon')
    end

 end

end
