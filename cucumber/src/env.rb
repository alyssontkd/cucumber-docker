require 'capybara'
require 'capybara/cucumber'
require 'capybara/rspec'
require 'selenium/webdriver'
require 'site_prism'
require 'faker'
require 'rspec'
require 'rspec/retry'


AMBIENTE = ENV['AMBIENTE']
CONFIG = YAML.load_file(File.dirname(__FILE__) + "/ambientes/#{AMBIENTE}.yml")
CUSTOM = YAML.load_file(File.dirname(__FILE__) + "/config.yml")

Capybara.server = :puma, { Silent: true }
Capybara.register_driver :chrome_headless do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new

  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-gpu')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1920,1080')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.verbose_retry = true
  config.default_retry_count = 2
  config.exceptions_to_retry = [Net::ReadTimeout]

  config.before(:each, type: :system, js: true) do
    driven_by :chrome_headless
  end
end
Capybara.javascript_driver = :chrome_headless

Capybara.configure do |config|
  #config.default_driver = :selenium_chrome # Com Navegador
  #config.default_driver = :selenium_chrome_headless # Sem navegador
  config.default_driver = :chrome_headless # Sem navegador customizado
  config.app_host = CONFIG['url_padrao']
  Capybara.default_max_wait_time = 15
end
