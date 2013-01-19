# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

require 'capybara/rails' 
require 'capybara/dsl' 
#require 'webmock/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.include(Capybara, :type => :integration) 
  config.include Capybara::DSL

  def logout
    
  end

  def login(user)
    
  end

  def log_in(user)
    #stub_request(:any, "127.0.0.1")
    #stub_request(:get, "http://127.0.0.1:51677/__identify__").
           #with(:headers => {'accept'=>'*/*', 'accept-encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'user-agent'=>'ruby'}).
           #to_return(:status => 200, :body => "", :headers => {})


    visit '/'
    click_link 'email_sign_in'
    fill_in 'Email', :with => user.email
    fill_in 'user_password', :with => 'abc123'
    click_button 'Sign in'
  end

  def sign_in(user)
    log_in(user)
  end

  def stub_subscription_service
   #stub_request(:post, "https://#{ListenLater::Application.config.subscription_service_username}:#{ListenLater::Application.config.subscription_service_password}@superfeedr.com/hubbub").
         #with(:headers => {'Accept'=>'application/atom+xml', 'User-Agent'=>'Typhoeus - https://github.com/typhoeus/typhoeus'}).
         #to_return(:status => 200, :body => "", :headers => {}) 

   class << SubscriptionService

     def subscribe(url, id)
      true 
     end

   end

  end


end
