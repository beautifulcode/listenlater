class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :subscriptions
  has_many :subscribed_series, :through => :subscriptions, :source => :series
  has_many :sources, :through => :subscribed_series

  def recent_sources
    sources.recent.ordered.includes(:subscription)
  end

  def suggested_sources
    sources.recent.ordered
  end


  def first_visit?
    sign_in_count == 1
  end

  def has_no_sources?
    sources.empty?
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource = nil)
    info = auth.extra.raw_info
    user = User.where(:facebook_id => info.id).first
    unless user
      user = User.new
      user.email = info.email
      user.facebook_id = info.id
      user.password = Devise.friendly_token[0,20]
      user.save!
    end
    user
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource = nil)
    data = auth
    user = User.where(:twitter_id => data.uid).first
    unless user
      user = User.new
      user.twitter_id = data.uid
      user.password = Devise.friendly_token[0,20]
      user.save!
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.facebook_id = data["id"]
      elsif data = session["devise.twitter_data"]
        user.twitter_id = data["uid"]
      end
      # TODO: add other providers
    end
  end

  def connect_with provider, authdata
    case provider
    when :twitter
      self.twitter_id = authdata['uid']
    when :facebook
      self.facebook_id = authdata['uid']
    end
    save
  end
end

class NullUser

  def id
    'anonymous'
  end

end
