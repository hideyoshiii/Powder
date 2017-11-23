class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :spots
  has_many :likes, dependent: :destroy
  has_many :questions
  has_many :answers, dependent: :destroy
  has_many :clips, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_attached_file :image, :styles => { :medium => "400x400", :thumb => "100x100>" }, :default_url => "avatar-default.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
	    user.name = auth.info.name   # assuming the user model has a name
	    user.image = "https://graph.facebook.com/#{auth.uid}/picture?type=large" # assuming the user model has an image
	    # If you are using confirmable and the provider(s) you use validate emails, 
	    # uncomment the line below to skip the confirmation emails.
	    # user.skip_confirmation!
	  end
	end
end
