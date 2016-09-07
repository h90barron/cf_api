# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'


Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  config.fixture_path = "#{::Rails.root}/spec/fixtures"


  config.use_transactional_fixtures = true


  config.infer_base_class_for_anonymous_controllers = false

  config.order = "random"

  config.infer_spec_type_from_file_location!
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Helpers::JsonHelpers, :type => :controller
  config.include Devise::TestHelpers, :type => :controller
  config.include Devise::TestHelpers, :type => :controller

end
  
require 'shoulda/matchers'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
  #choose a test framework
  with.test_framework :rspec
  
  #choose one or more libraries
  #or choose :rails which implies all libs (active_record, active_model etc)
  with.library :rails
  end
end
