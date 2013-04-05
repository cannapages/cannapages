Devise.setup do |config|
  config.mailer_sender = "please-change-me-at-config-initializers-devise@example.com"
  require 'devise/orm/mongoid'
  config.strip_whitespace_keys = [ :email ]
  config.reconfirmable = true
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete

	#Social media
	config.omniauth :facebook, "463333910400304", "5df7da26188c046815e24ca307a6fb9d"
end
