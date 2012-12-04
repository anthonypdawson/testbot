require 'status.rb'
require 'rubygems'
require 'system_timer'

class Time

  def to_pretty
    self.strftime("%m-%d-%Y %H:%M")
  end

  def elapsed_time(started_on)
    difference = (self - started_on)
    seconds    =  difference % 60
    difference = (difference - seconds) / 60
    minutes    =  difference % 60
    difference = (difference - minutes) / 60
    hours      =  difference % 24
    difference = (difference - hours)   / 24
    return "#{sprintf('%2.2d',hours)}:#{sprintf('%2.2d',minutes)}:#{sprintf('%2.2d',seconds)}"
  end
end

class TestSuiteExecution < ActiveRecord::Base
  has_and_belongs_to_many :test_suites
  has_and_belongs_to_many :test_cases
  has_and_belongs_to_many :browsers
  has_many :results
  belongs_to :selenium_server
  belongs_to :project
  belongs_to :revision
  belongs_to :environment

  validates_presence_of :environment_id, :revision_id, :project, :browsers, :selenium_server, :description

  def validation
    if !self.is_test
      errors.add_on_empty %w(test_suites)
    end
  end
  def pretty_status
    case self.status
      when Status::NOTSTARTED
        "Pending"
      when Status::STARTED
        "Executing"
      when Status::COMPLETE
        "Complete"
      when Status::INTERRUPTED
        "Interrupted"
      else
        "Unknown"
    end
  end

  def failed?
    self.failure_count > 0
  end

  def failure_count
    self.test_suites.select {|ts| ts.failed?(self.id) }.length
  end

  def pass_count
    self.test_suites.select {|ts| ts.passed?(self.id) }.length
  end

  def passed?
    return (self.pass_count > 0 and self.failure_count == 0)
  end

  def test_status
    return self.pretty_status if self.pretty_status != "Complete"
    return "Passed" if self.passed?
    return "Failed" if self.failed?
    return "Complete"
  end

  def test_suite_status(test_suite)
    if test_suite.nil?
    else
      return test_suite.status(self.id)
    end
  end

  def test_case_status

  end

  def pretty_date
    self.created_on.strftime("%m-%d-%Y %H:%M")
  end

  def run
    puts "Starting Test Suite Execution #{self.id}\n"
    self.status = Status::STARTED
    self.started_on = Time.now
    self.save
    begin
      self.run_all
    rescue SocketError
      self.status = Status::INTERRUPTED
      self.save
      puts "Interruption in Test Suite Execution #{self.id}\n"
    else
      self.status = Status::COMPLETE
      self.completed_on = Time.now
      self.save
      puts "Completed Test Suite Execution #{self.id}\n"
    end
  end

  def run_all
    self.browsers.uniq.each do |b|
      self.selenium_server.create_driver(b, self.environment.base_url)
      self.test_suites.each do |t|
        t.run(self.selenium_server, {:project_id => self.project.id, :test_suite_execution_id => self.id}) do |result|
          puts "Saving result"
          result.save
          puts "Result saved"
        end
      end
      self.test_cases.each do |t|
        puts "Running test case"
        self.run_test_case(t)
      end
      sleep 1
    end
  end

  def run_test_case(t)
    begin
      result = t.run(self.selenium_server, { :project_id => self.project.id, :test_suite_execution_id => self.id})
    rescue SocketError
      raise SocketError
    end
    puts "Saving result"
    result.save
  end

  def interrupted?
    return self.status == Status::INTERRUPTED
  end

  def pending?
    return self.not_started?
  end

  def running?
    return self.started?
  end

  def started?
    return self.status == Status::STARTED
  end

  def not_started?
    return self.status == Status::NOTSTARTED
  end

  def complete?
    return self.status == Status::COMPLETE
  end

  def test_suite_results(test_suite=nil)
    if test_suite.nil?
      return self.results.select{|result| result.test_suite_id.nil?}
    end
    self.results.select{|result| result.test_suite_id == test_suite.id}
  end

  def elapsed_time
    return "Not Complete" if self.completed_on.nil?
    return self.completed_on.elapsed_time(self.started_on)
  end

end
