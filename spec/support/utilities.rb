include ApplicationHelper

def capybara_signin(user)
  fill_in 'Email', :with => user.email
  fill_in 'Password', :with => user.password
  click_button 'Sign in'
end

def omniauth_mock(provider, email, name)
  OmniAuth.config.add_mock(provider, {
    :uid => '123545',
    :provider => provider,
    :info => { :email => email, :name => name }
  })
end

def omniauth_signin
  visit root_path
  click_link 'Sign in'
  find(:xpath, "//a/img[contains(@alt,'Fblogin')]/..").click
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.has_selector? 'div.alert.alert-danger', :text => message
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    page.has_selector? 'div.alert.alert-success', :text => message
  end
end

RSpec::Matchers.define :have_notice_message do |message|
  match do |page|
    page.has_selector? 'div.alert.alert-info', :text => message
  end
end

RSpec::Matchers.define :have_page_title do |title|
  match do |page|
    page.has_title? full_title(title)
  end
end

RSpec::Matchers.define :have_page_heading do |heading|
  match do |page|
    page.has_selector? 'h1', :text => heading
  end
end

RSpec::Matchers.define :have_url do |url|
  match do |page|
    page.current_url == url
  end
end

RSpec::Matchers.define :have_delete_link do |text, link|
  match do |page|
    page.has_selector?("a[data-method=delete][href=\"#{link}\"]", :text => text)
  end
end
