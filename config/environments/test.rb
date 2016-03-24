CloudBenchmarking::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure serving files from the public folder with Cache-Control for performance.
  config.serve_static_files  = true
  config.static_cache_control = "public, max-age=3600"

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  # Local file resources used for testing
  config.spec_files = "#{Rails.root}/spec/files"

  # Override environment variables to prevent tests from starting instances.
  ENV['AWS_ACCESS_KEY'] = 'dummy_aws_access_key_for_testing'
  ENV['AWS_SECRET_KEY'] = 'dummy_aws_secret_key_for_testing'
  ENV['GOOGLE_PROJECT_ID'] = 'dummy_google_project_id_for_testing'
  ENV['GOOGLE_CLIENT_EMAIL'] = 'dummy_google_client_email_for_testing'
  ENV['GOOGLE_KEY_LOCATION'] = 'dummy_google_key_location_for_testing'
  ENV['KNIFE_CHEF_SERVER_URL'] = 'dummy_knife_chef_url_for_testing'
end
