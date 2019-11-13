require 'capybara'
require 'capybara/cucumber'
require 'capybara/rspec'
require 'headless'
require 'selenium/webdriver'
require 'site_prism'
require 'faker'
require 'rubygems'
require 'rspec'
require 'rspec/retry'


AMBIENTE = ENV['AMBIENTE']
CONFIG = YAML.load_file(File.dirname(__FILE__) + "/ambientes/#{AMBIENTE}.yml")
CUSTOM = YAML.load_file(File.dirname(__FILE__) + "/config.yml")

Capybara.register_driver :headless_chromium do |app|
  caps = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: {
          args: %w{headless disable-gpu no-sandbox window-size=1280x1000},
          binary:  '/usr/bin/chromium'
      }
  )
  driver = Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: caps)
end

Capybara.register_driver(:headless_chrome_vertenti) do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new
  #options
  options.add_argument('--disable-web-security')
  options.add_argument('--start-maximized')
  options.add_argument('--disable-infobars')
  options.add_argument('--disable-extensions')
  options.binary = '/usr/bin/google-chrome-stable'
  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--window-size=1920,1080')
  Capybara::Selenium::Driver.new(app, browser: :chrome, driver_path: '/usr/bin/chromedriver', options: options)
end

Capybara.configure do |config|
  config.default_driver = :headless_chromium # Sem navegador customizado
  #config.default_driver = :headless_chrome_vertenti # Sem navegador customizado
  config.app_host = CONFIG['url_padrao']
  Capybara.default_max_wait_time = 100
end
