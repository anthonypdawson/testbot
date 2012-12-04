require 'ActiveRecordConnection'
require 'browser'
require 'selenium_server'
require 'test_suite'
require 'status'
require 'test_suite_execution'
require 'test_case'
require 'project'
require 'result'
require 'snippet'
require 'environment'
require 'revision'
require 'rubygems'
require 'system_timer'

# Test bot daemon runs in the background and processes any pending test suite execution requests
# Typical command would look like
##   ruby test_bot.rb production
class TestBot
  # Keep track of threads in threaded mode
  attr_accessor :tasks

  # Set threaded mode and environment
  def initialize(env, threaded=false)
    @threaded = threaded
    puts "Starting up in #{env}!"
    @tasks = []
    ActiveRecord::Base.connect_to_testbot(env)
    loop
  end

  private

  # Check DB for new test_suite_executions
  # Run each and sleep for 10s
  # In threaded mode, spawn a new thread for each TSE
  def loop
    while(1==1)
      tse = TestSuiteExecution.find(:all, :conditions => "status = 'n'")
      if @threaded
        tse.each {|t| @tasks << Thread.new(t){ |ts| execute(ts) } }
      else
        tse.each {|t| execute(t) }
      end
      sleep 10
    end
  end

  # Run the TSE, catch any errors (most likely due to server being down)
  def execute(tse)
    begin
      tse.run
    rescue
      puts $!
      puts $!.backtrace.join()
      tse.status = Status::INTERRUPTED
      tse.selenium_server.driver.stop if !tse.selenium_server.driver.nil?
      tse.save
    end
  end

end

ENVIRONMENT = {"development" => "testbot_development", "test" => "testbot_test", "production" => "testbot"}
if ARGV.first.nil?
  env = "production"
else
  env = ARGV.first
end
if !ENVIRONMENT.keys.include?(env)
  puts "Environment invalid"
else
  t = TestBot.new(ENVIRONMENT[env])
end
