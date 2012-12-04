require File.dirname(__FILE__) + '/../test_helper'

class TestCaseTest < Test::Unit::TestCase
  fixtures :test_cases

  # Replace this with your real tests.
  def test_truth
    assert (test_cases(:first).is_a?TestCase)
  end
end
