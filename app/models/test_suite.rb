class TestSuite < ActiveRecord::Base
  belongs_to :project
  has_and_belongs_to_many :test_cases
  has_many :results

  validates_presence_of :name, :project_id
  validates_uniqueness_of :name

  def run(server, options)
    self.test_cases.each do |tc|
      begin
        result = tc.run(server, options)
      rescue SocketError
        raise SocketError
      end
      self.results << result
      yield result
    end
  end

  def passed?(tse_id)
    return ((self.success_count(tse_id) > 0) and (self.failure_count(tse_id) == 0))
  end

  def failed?(tse_id)
    return self.failure_count(tse_id) > 0
  end

  def failure_count(tse_id)
    self.results.select{|r| r if r.failed? and r.test_suite_execution_id == tse_id }.length
  end

  def success_count(tse_id)
    self.results.select{|r| r if r.passed? and r.test_suite_execution_id == tse_id }.length
  end

  def status(tse_id)
    return "Failed" if self.failed?(tse_id)
    return "Passed" if self.passed?(tse_id)
    return "Not Run"
  end

  def archive
    self.is_active = false
    self.save
  end
end
