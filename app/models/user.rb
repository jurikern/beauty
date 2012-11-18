class User < ActiveRecord::Base
  devise :database_authenticatable, :encryptable, :omniauthable

  attr_accessible :username, :provider, :uid, :access_token, :email

  @graph = false

  has_one  :profile
  has_one  :employer
  has_many :employees

  validates :email,              presence: true, uniqueness: true
  validates :username,           presence: true, uniqueness: true
  validates :uid,                presence: true, :uniqueness => { scope: [:provider] }
  validates :provider,           presence: true
  validates :encrypted_password, presence: true
  validates :password_salt,      presence: true

  def graph
    @fb_graph || @fb_graph = Koala::Facebook::API.new(self.access_token)
  end

  def puts_to_feed(message=nil)
    graph.put_connections('me', 'feed', message: message) if message.present?
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    user_hash = {
        username:     auth.extra.raw_info.username,
        provider:     auth.provider,
        uid:          auth.uid,
        access_token: auth.credentials.token,
        email:        auth.extra.raw_info.email
    }
    profile_hash = {
        name:   auth.extra.raw_info.name,
        logo:   auth.info.image,
        link:   auth.extra.raw_info.link,
        gender: auth.extra.raw_info.gender
    }
    unless user
      user = User.new(user_hash)
      user.password = Devise.friendly_token[4,20]
      user.build_profile(profile_hash)
      user.save
    else
      user.update_attributes(user_hash)
      user.profile.update_attributes(profile_hash) if user.profile.present?
    end
    user
  end
end
