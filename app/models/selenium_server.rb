require 'rubygems'
gem 'Selenium'
require 'selenium'

# Interface to the server running selenium r/c
class SeleniumServer < ActiveRecord::Base
  has_and_belongs_to_many :browsers
  attr_accessor :current_browser, :driver

  validates_presence_of :name, :host_name, :port, :browsers

  validates_uniqueness_of :name

  # Establish a connection to the selenium server
  def create_driver(browser, base_url)
    if !@driver.nil?
      @driver.stop
    end
    @current_browser = browser
    puts "Starting driver with the fields #{self.host_name}, #{self.port}, #{browser.selenium_name}, #{base_url}"
    @driver = Selenium::SeleniumDriver.new(self.host_name, self.port, browser.selenium_name, base_url, 10000)
    puts "Driver created"
  end

  def archive
    self.is_active = false
    self.save
  end

end
