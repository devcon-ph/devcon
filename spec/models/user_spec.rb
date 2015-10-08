#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  name                   :string(255)
#  roles_mask             :integer
#

require 'spec_helper'

describe User, :type => :model do
  before do
    @user = Fabricate(:user)
  end

  subject { @user }

  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:password) }
  it { is_expected.to respond_to(:password_confirmation) }
  it { is_expected.to respond_to(:encrypted_password) }
  it { is_expected.to respond_to(:reset_password_token) }
  it { is_expected.to respond_to(:reset_password_sent_at) }
  it { is_expected.to respond_to(:remember_me) }
  it { is_expected.to respond_to(:remember_created_at) }
  it { is_expected.to respond_to(:sign_in_count) }
  it { is_expected.to respond_to(:current_sign_in_at) }
  it { is_expected.to respond_to(:last_sign_in_at) }
  it { is_expected.to respond_to(:current_sign_in_ip) }
  it { is_expected.to respond_to(:last_sign_in_ip) }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:articles) }
  it { is_expected.to respond_to(:roles) }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.not_to allow_value('user@foo,com').for(:email) }
  it { is_expected.not_to allow_value('user_at_foo.org').for(:email) }
  it { is_expected.not_to allow_value('example.user@foo.').for(:email) }
  it { is_expected.to allow_value('user@foo.com').for(:email) }
  it { is_expected.to allow_value('A_USER@f.b.org').for(:email) }
  it { is_expected.to allow_value('frst.lst@foo.jp').for(:email) }
  it { is_expected.to allow_value('a+b@baz.cn').for(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  describe 'when password is not present' do
    before { @user.password = @user.password_confirmation = ' ' }
    it { is_expected.not_to be_valid }
  end

  describe 'when password does not match confirmation' do
    before { @user.password_confirmation = 'mismatch' }
    it { is_expected.not_to be_valid }
  end

  describe 'when a password is too short' do
    before { @user.password = @user.password_confirmation = 'a' * 5 }
    it { is_expected.to be_invalid }
  end

  describe 'article associations' do
    before { @user.save }
    let!(:older_articles) do
      Fabricate(:article, :author => @user, :created_at => 1.day.ago)
    end
    let!(:newer_articles) do
      Fabricate(:article, :author => @user, :created_at => 1.hour.ago)
    end

    it 'should have the right articles in the right order' do
      expect(@user.articles).to eq([newer_articles, older_articles])
    end

    it 'should destroy associated articles' do
      articles = @user.articles
      @user.destroy
      articles.each do |article|
        expect(Article.find_by_id(article.id)).to be_nil
      end
    end
  end
end
