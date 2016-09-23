require 'selenium-webdriver'
require 'yaml'

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|

    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end


  config.mock_with :rspec do |mocks|

    mocks.verify_partial_doubles = true
  end


  config.shared_context_metadata_behavior = :apply_to_host_groups


end

def url(url)
  "http://localhost:3000" + url
end

def register
  @driver.navigate.to url('/users/new')
  username = @driver.find_element(name: 'username')
  username.send_keys @username
  email = @driver.find_element(name: 'email')
  email.send_keys @email
  password = @driver.find_element(name: 'password')
  password.send_keys @password
  submitBtn = @driver.find_element(css: 'body > form > input[type="submit"]').click
end

def login
  @driver.navigate.to url('/sessions/new') if @driver.current_url != url('/sessions/new')
  email = @driver.find_element(name: 'email')
  email.send_keys @email
  password = @driver.find_element(name: 'password')
  password.send_keys @password
  submitBtn = @driver.find_element(css: 'body > form > input[type="submit"]').click
end

def logout
  #clickLogout = @driver.find_element(xpath: ' /html/body/nav/form/input[2]').click
end
