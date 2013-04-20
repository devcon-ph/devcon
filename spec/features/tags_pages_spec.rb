require 'spec_helper'

describe "Tags pages" do

  subject { page }

  describe 'for anonymous users' do
    describe 'in the index page' do
      before { visit tags_path }

      it { should have_page_title 'Tags' }
      it { should have_page_heading 'Tags' }
    end
  end

  describe 'for signed-in users' do
    describe 'as a regular user' do
      before do
        @user = Fabricate(:user)
        visit new_user_session_path
        capybara_signin(@user)
      end

      describe 'in the index page' do
        before { visit tags_path }

        it { should have_page_title 'Tags' }
        it { should have_page_heading 'Tags' }
        it { should_not have_link 'New Tag' }
        it { should_not have_link 'Edit' }
        it { should_not have_link 'Destroy' }
      end

      describe 'in the show page' do
        before do
          @tag = Fabricate(:tag)
          visit tag_path(@tag)
        end

        it { should have_page_title @tag.name }
        it { should have_page_heading @tag.name }
        it { should have_link 'Back to tags' }
        it { should_not have_link 'Edit' }
        it { should_not have_link 'Destroy' }
      end

      describe 'in the new page' do
        before { visit new_tag_path }

        it { should have_error_message 'Access denied' }
        it { should have_page_title '' }
      end

      describe 'in the edit page' do
        before do
          @tag = Fabricate(:tag)
          visit edit_tag_path(@tag)
        end

        it { should have_error_message 'Access denied' }
        it { should have_page_title '' }
      end
    end

    describe 'as an author' do
      before do
        @author = Fabricate(:author)
        visit new_user_session_path
        capybara_signin(@author)
      end

      describe 'in the index page' do
        before { visit tags_path }

        it { should have_page_title 'Tags' }
        it { should have_page_heading 'Tags' }
        it { should have_link 'New Tag' }

        describe 'with a list of tags' do
          before do
            @tag = Fabricate(:tag)
            visit tags_path
          end

          it { should have_link @tag.name }
          it { should have_link 'Edit' }
          it { should_not have_link 'Destroy' }
        end
      end

      describe 'in the show page' do
        before do
          @tag = Fabricate(:tag)
          visit tag_path(@tag)
        end

        it { should have_page_title @tag.name }
        it { should have_page_heading @tag.name  }
        it { should have_link 'Back to tags' }
        it { should have_link 'Edit' }
        it { should_not have_link 'Destroy' }
      end

      describe 'in the new page' do
        before { visit new_tag_path }

        it { should have_page_title 'New tag' }
        it { should have_page_heading 'New tag' }
        it { should have_link 'Back to tags' }

        describe 'with invalid information' do
          it 'should not create a tag' do
            expect { click_button 'Create' }.to_not change(Tag, :count)
          end

          describe 'on error messages' do
            before { click_button 'Create' }
            it { should have_error_message 'error' }
          end
        end

        describe 'with valid information' do
          before do
            fill_in 'Name', :with => 'Foobar'
            fill_in 'Description', :with => 'Lolol'
          end

          it 'should create a tag' do
            expect { click_button 'Create' }.to change(Tag, :count)
          end

          describe 'on success messages' do
            before { click_button 'Create' }
            it { should have_success_message 'created' }
          end
        end
      end

      describe 'in the edit page' do
        before do
          @tag = Fabricate(:tag)
          visit edit_tag_path(@tag)
        end

        it { should have_page_title 'Edit tag' }
        it { should have_page_heading 'Edit tag' }
        it { should have_link 'Back to tags' }

        describe 'with invalid information' do
          before do
            fill_in 'Name', :with => ' '
            click_button 'Update'
          end

          it { should have_error_message 'error' }
        end

        describe 'with valid information' do
          before do
            fill_in 'Name', :with => 'Barfoo'
            click_button 'Update'
          end

          it { should have_success_message 'updated' }
        end
      end
    end
  end
end
