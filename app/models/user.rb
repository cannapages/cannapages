class User
  include Mongoid::Document
	include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :user_name,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""
	field :provider, type: String
	field :uid, type: String
	field :roles, type: Array
 
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

	attr_accessible :email, :user_name, :password, :password_confirmation, :provider, :uid

	#Relationships
	has_many :reviews

	#Validations
  validates_presence_of :encrypted_password

	before_validation :insure_basic_role

	def insure_basic_role
		self.roles ||= ["Basic"]
	end

	#Methods
	def email_required?
    super && provider.blank?
	end

	def self.find_oauth(auth, signed_in_resource=nil)
		user = User.where(:provider => auth.provider, :uid => auth.uid).first
		unless user
			user = User.create(name:auth.extra.raw_info.name,
													 provider:auth.provider,
													 uid:auth.uid,
													 email:auth.info.email,
													 password:Devise.friendly_token[0,20]
													 )
		end
		user
	end

end
