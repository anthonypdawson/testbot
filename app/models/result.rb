# Represents the outcome of a test case
class Result < ActiveRecord::Base
  belongs_to :test_suite_execution
  belongs_to :test_case
  belongs_to :browser
  belongs_to :test_suite
  belongs_to :project
  serialize :successes
  serialize :failures

  # String representation of the current status
  def status
    return "Passed" if self.passed?
    return "Failed" if self.failed?
    return "Not Run"
  end

  # Interface into internal array of failures
  def failure_list
    if self.failures.nil?
      return []
    end
    return self.failures
  end

  # Interface into internal array of successes
  def success_list
    if self.successes.nil?
      return []
    end
    return self.successes
  end

  # Add a success to the result
  def add_success(success)
    self.successes = [] if self.successes.nil?
    self.successes << success
  end

  # Add a failure to the result
  def add_failure(failure)
    self.failures = [] if self.failures.nil?
    self.failures << failure
  end

  def failure_count
    return self.failure_list.length
  end

  def success_count
    return self.success_list.length
  end

  def passed?
    return ((self.success_count > 0) and (self.failure_count == 0))
  end

  def failed?
    return self.failure_count > 0
  end

end
