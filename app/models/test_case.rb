require 'system_timer'

class TestCase < ActiveRecord::Base
  has_and_belongs_to_many :test_suites
  has_many :results
  belongs_to :project

  validates_presence_of :project_id, :name
  validates_uniqueness_of :name

  # Create a result and run self with given server and options
  # Options hash = {:project_id, :test_suite_execution_id}
  def run(server, options)
    @result = Result.new(:project_id => options[:project_id], :test_suite_execution_id => options[:test_suite_execution_id])
    @result.browser = server.current_browser
    @result.test_case = self
    @selenium = server.driver
    begin
      SystemTimer.timeout(30) do
        @selenium.start
      end
    rescue Timeout::Error
      puts "Timed out waiting for driver"
      @result.add_failure "Selenium Driver timed out"
      return @result
    rescue SocketError
      puts "Couldn't connect to server"
      raise SocketError
    end
    run_script(self.setup_script)
    run_script(self.execute_script)
    run_script(self.teardown_script)
    @selenium.stop
    return @result
  end

  private

  def run_snippet(snippetId)
    begin
      snippet = Snippet.find(snippetId)
      run_script(snippet.script)
    rescue
      @result.add_failure "#{$!} running snippet #{snippetId}"
    end
  end

  # Eval the script blocks
  # Fail on any uncaught exceptions
  def run_script(script)
    begin
      instance_eval(script)
    rescue
      @result.add_failure $!
    end
  end

  # Assert conditions are equal
  # Uses assert method
  def assert_equal(cond_a, cond_b, text=nil)
    assert(cond_a==cond_b, "#{text} Expected #{cond_a} to match #{cond_b}")
  end

  # Assert condition is not nil
  # Uses assert method
  def assert_not_nil(actual, message="")
      assert(!actual.nil?, message)
  end

  # Takes condition and text description
  # Add to instance failures or successes list
  def assert(assertion, text=nil)
    if assertion
      if !text.nil?
        @result.add_success(text)
      else
        @result.add_success "#{caller.first}"
      end
    else
      @result.add_failure "Assertion Failed!\n#{text}"
    end
  end

end
