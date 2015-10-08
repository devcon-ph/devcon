require 'spork'
require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start 'rails' do
  add_filter 'app/secrets'
end

Spork.prefork do
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)

  require 'rspec/rails'
  require 'capybara/rails'
  require 'capybara/rspec'

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end

  RSpec.configure do |config|
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr

    config.before :suite do
      # PerfTools::CpuProfiler.start("/tmp/rspec_profile")
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end

    # Request specs cannot use a transaction because Capybara runs in a
    # separate thread with a different database connection.
    config.before type: [:request, :feature] do
      DatabaseCleaner.strategy = :truncation
    end

    # Reset so other non-request specs don't have to deal with slow truncation.
    config.after type: [:request, :feature]  do
      DatabaseCleaner.strategy = :transaction
    end

    RESERVED_IVARS = %w(@loaded_fixtures)
    last_gc_run = Time.now

    config.before(:each) do
      GC.disable
    end

    config.before do
      DatabaseCleaner.start
    end

    config.after do
      DatabaseCleaner.clean
    end

    # Release instance variables and trigger garbage collection
    # manually every second to make tests faster
    # http://blog.carbonfive.com/2011/02/02/crank-your-specs/
    config.after(:each) do
      (instance_variables - RESERVED_IVARS).each do |ivar|
        instance_variable_set(ivar, nil)
      end
      if Time.now - last_gc_run > 1.0
        GC.enable
        GC.start
        last_gc_run = Time.now
      end
    end
    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = false

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false
  end
end

Spork.each_run do
  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
end
