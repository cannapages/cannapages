class User
  include Mongoid::Document
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
	has_and_belongs_to_many :listings_reviewed, :class_name => 'Listing', :inverse_of => nil

	#Validations
  validates_presence_of :email
  validates_presence_of :encrypted_password
	validates_format_of :password, with: /[a-z]+[0-9]+/i, unless: Proc.new { |user| user.password.nil?  }
	validates_length_of :password, minimum: 8, maximum: 16, unless: Proc.new { |user| user.password.nil?  }
end
