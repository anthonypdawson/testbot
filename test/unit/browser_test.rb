require File.dirname(__FILE__) + '/../test_helper'

class BrowserTest < Test::Unit::TestCase
  fixtures :browsers
  fixtures :selenium_servers
  # Replace this with your real tests.
  def test_new
    # clone
    browser = Browser.new :name => browsers(:first).name,
                          :path => browsers(:first).path,
                          :selenium_name => browsers(:first).selenium_name
    # Non-unique name should fail a save
    assert !browser.save
    browser.name = "Test"

    # working save
    assert browser.save

    assert browser == Browser.find(browser.id)

    assert browser.created_on = "2008-10-02 17:23:43"

    # test update
    assert browser.update

    assert browser.destroy
  end

  def test_relationships
    bFirst = browsers(:first)
    assert !bFirst.selenium_servers.nil?
    selenium_servers(:first).browsers << bFirst
    selenium_servers(:first).update
    bFirst.update
    assert bFirst.selenium_servers.first.is_a?(SeleniumServer)
  end

end
