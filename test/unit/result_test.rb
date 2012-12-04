require File.dirname(__FILE__) + '/../test_helper'

class ResultTest < Test::Unit::TestCase
  fixtures :results


  def test_create
    r = Result.new :test_suite_execution => results(:first).test_suite_execution, :test_case => results(:first).test_case,
                   :browser => results(:first).browser, :test_suite => results(:first).test_suite, :project => results(:first).project
    assert r.save
    assert r.is_a?(Result)
    assert r.update
    assert r.destroy
  end

  def test_relationships
    rFirst =  Result.new :test_suite_execution => results(:first).test_suite_execution, :test_case => results(:first).test_case,
                   :browser => results(:first).browser, :test_suite => results(:first).test_suite, :project => results(:first).project
    assert rFirst.test_suite_execution.is_a?(TestSuiteExecution)
    assert rFirst.test_case.is_a?(TestCase)
    assert rFirst.browser.is_a?(Browser)
    assert rFirst.test_suite.is_a?(TestSuite)
    assert rFirst.project.is_a?(Project)
    assert rFirst.success_list.is_a?(Array)
    assert rFirst.failure_list.is_a?(Array)
  end

  def test_methods
    rFirst = results(:first)
    sCount = rFirst.success_count + 1
    fCount = rFirst.failure_count + 1
    rFirst.add_success("test")
    assert rFirst.success_count == sCount
    rFirst.add_failure("test")
    assert rFirst.failure_count == fCount
    assert !rFirst.passed?
    assert rFirst.failed?
    rFirst = Result.new
    assert !rFirst.passed?
    rFirst.add_success("test")
    assert rFirst.passed?
  end
end
