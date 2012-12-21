require "selenium-webdriver"
require "test/unit"

class Test1 < Test::Unit::TestCase

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "http://timescity.com/"
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end
  
  def test_1
    @driver.get(@base_url + "/")
    @driver.find_element(:link, "Christmas Parties").click
    @driver.find_element(:id, "dropdownlocation_title").click
    @driver.find_element(:id, "dropdownlocation").click
    @driver.find_element(:css, "#dropdownlocation_msa_3 > span.ddTitleText").click
    @driver.find_element(:id, "dropdownlocation").click
    @driver.find_element(:id, "eventtype_1").click
    @driver.find_element(:xpath, "(//a[contains(text(),'X')])[2]").click
    @driver.find_element(:link, "Home").click
  end
  
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
end
