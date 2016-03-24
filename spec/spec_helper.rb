require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

# Loading more in this block will cause your tests to run faster. However,
# if you change any configuration or code from libraries loaded here, you'll
# need to restart spork for it take effect.
Spork.prefork do
  unless ENV['DRB']
    require 'simplecov_rails_custom'
    SimpleCov.start 'rails' do
      configure_simple_cov
    end
  end

  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  # Support for deprecated `its` in RSpec 3 discussed in: https://gist.github.com/myronmarston/4503509
  require 'rspec/its'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and spec/features/support and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
  Dir[Rails.root.join("spec/features/support/**/*.rb")].each { |f| require f }

  # Run pending migrations automatically if any
  ActiveRecord::Migration.maintain_test_schema!

  RSpec.configure do |config|
    config.infer_spec_type_from_file_location!
    config.treat_symbols_as_metadata_keys_with_true_values = true

    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    # config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = "random"

    config.include FactoryGirl::Syntax::Methods
    config.include Capybara::DSL
    config.include AuthenticationHelpers, type: :feature

    # Must be false for Selenium support
    config.use_transactional_fixtures = false

    # Authentication helper
    config.after(:each) do
      Warden.test_reset!
    end

    # Database cleaner
    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    # FactoryGirl
    config.before(:suite) do
      begin
        DatabaseCleaner.start
        FactoryGirl.lint
      ensure
        DatabaseCleaner.clean
      end
    end

    # Clean file system
    config.after(:all) do
      if Rails.env.test? || Rails.env.cucumber?
        FileUtils.rm_rf Dir[Rails.application.config.storage]
      end
    end
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
  if ENV['DRB']
    require 'simplecov_rails_custom'
    SimpleCov.start 'rails' do
      configure_simple_cov
    end
  end
end