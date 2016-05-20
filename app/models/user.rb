# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)
#  roles_mask             :integer
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :articles, :foreign_key => 'author_id', :dependent => :destroy

  has_many :authentications, :dependent => :destroy

  validates :email, :presence => true, :email => true

  ROLES = %w[admin moderator author]

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include?(role.to_s)
  end

  def password_required?
      (authentications.empty? || !password.blank) && super
  end

  def self.from_omniauth(auth)
    user = where(email: auth.info.email).first

    unless user.nil?
      provider = Authentication.where(provider: auth.provider, uid: auth.uid, user_id: user).first

      if provider.nil?
        user.authentications.create!(provider: auth.provider, uid: auth.uid)
        user.name = auth.info.name
      end
    end
    user
  end
end
