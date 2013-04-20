require 'spec_helper'

describe 'User' do

  subject { page }

  describe 'profile page' do

    before do
      @user = Fabricate(:user)
      visit user_path(@user)
    end

    describe 'when a user has a name' do

      it { should have_page_heading @user.name }
      it { should_not have_page_heading @user.email }
    end

    describe 'when a user does not have a name' do

      before do
        @user = Fabricate(:user, :name => ' ')
        visit user_path(@user)
      end

      it { should have_page_heading @user.email }
    end

    describe 'as an author' do

      before do
        @author = Fabricate(:author)
        @article = Fabricate(:article, :author => @author)
        visit user_path(@author)
      end

      it { should have_link @article.title }
      it { should have_content @author.articles.count }
    end
  end

  #describe 'signup page' do

    #before { visit new_user_session_path }

    #it { should_not have_link 'Sign up' }
  #end

  describe 'signing up' do

    before { visit new_user_registration_path }

    it 'should redirect to root' do
      current_path.should == root_path
    end
    #describe 'with invalid information' do

      #it 'should not create a user' do
        #expect { click_button 'Sign up' }.not_to change(User, :count)
      #end
    #end

    #describe 'with valid information' do

      #before do
        #fill_in 'Email', :with => 'user@example.com'
        #fill_in 'Password', :with => 'foobar'
        #fill_in 'Password confirmation', :with => 'foobar'
      #end

      #it 'should create a user' do
        #expect { click_button 'Sign up' }.to change(User, :count).by(1)
      #end

      #describe 'after saving the user' do

        #before { click_button 'Sign up' }

        #it { should have_notice_message 'Welcome!' }
        #it { should have_link 'Profile' }
        #it { should have_link 'Settings' }
        #it { should have_link 'Sign out' }
        #it { should_not have_link 'Sign up' }
        #it { should_not have_link 'Sign in' }
      #end
    #end
  end
end
