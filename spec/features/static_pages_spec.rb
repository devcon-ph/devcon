require 'spec_helper'

describe 'Static pages' do

  subject { page }

  shared_examples_for 'all static pages' do
    it { should have_page_title page_title }
  end

  describe 'Home page' do
    before { visit root_path }
    let(:heading)    { 'Developers Connect' }
    let(:page_title) { '' }

    it_should_behave_like 'all static pages'
    it { should_not have_page_title 'Home -' }
  end

  describe 'Contact page' do
    before { visit contact_path }
    let(:heading)    { 'Contact' }
    let(:page_title) { 'Contact' }

    it_should_behave_like 'all static pages'
  end

  describe 'FAQ page' do
    before { visit faq_path }
    let(:heading)    { 'Frequently Asked Questions' }
    let(:page_title) { 'Frequently Asked Questions' }

    it_should_behave_like 'all static pages'
  end

  it 'should have the right links on the layout' do
    visit root_path
    click_link 'Contact'
    page.should have_page_title 'Contact'
    click_link 'Home'
    page.should have_page_title ''
    click_link 'Sign in'
    page.should have_page_title 'Sign in'
    click_link 'Articles'
    page.should have_page_title 'Articles'
    click_link 'Events'
    page.should have_page_title 'Events'
    click_link 'FAQ'
    page.should have_page_title 'Frequently Asked Questions'
  end
end
