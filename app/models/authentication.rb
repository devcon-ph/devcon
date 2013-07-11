class Authentication < ActiveRecord::Base
  belongs_to :user
  attr_accessible :provider, :uid

  def self.find_by_provider_and_uid(provider, uid)
    where(provider: provider, uid: uid).first
  end
end
