C41::Application.configure do
  config.cache_classes = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.serve_static_assets = false

  config.assets.compress = true

  config.assets.compile = false

  config.assets.digest = true

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

	config.assets.precompile += %w( map.css )

	config.action_mailer.default_url_options = { :host => 'cannapages.com' }

  require 'jquery/modal/rails'
  require 'jquery/modal/filters'
  require 'jquery/modal/helpers'

end
