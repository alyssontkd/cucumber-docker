require 'capybara'
require 'capybara/cucumber'
require 'selenium/webdriver'
require 'site_prism'
require 'faker'
require 'rspec'

AMBIENTE = ENV['AMBIENTE']
CONFIG = YAML.load_file(File.dirname(__FILE__) + "/ambientes/#{AMBIENTE}.yml")
CUSTOM = YAML.load_file(File.dirname(__FILE__) + "/config.yml")

Capybara.register_driver :chrome_headless do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new

  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1400,1400')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :chrome_headless

Capybara.configure do |config|
  #config.default_driver = :selenium_chrome # Com Navegador
  #config.default_driver = :selenium_chrome_headless # Sem navegador
  config.default_driver = :chrome_headless # Sem navegador customizado
  config.app_host = CONFIG['url_padrao']
  Capybara.default_max_wait_time = 15
end
