# Represents a project typically with its own QA cycle
class Project < ActiveRecord::Base
  has_many :test_suites
  has_many :test_cases
  has_many :snippets
  has_many :revisions
  has_many :environments
  has_many :test_suite_executions
  validates_presence_of :name
  validates_uniqueness_of :name


  def to_s
    self.name
  end

  def version
    return "" if self.revisions.empty?
    return self.current_revisions.last.version
  end

  def current_revisions
    return self.revisions.select{|revision| revision.current?}
  end

  def current_environments
    return self.environments.select{|environment| environment.current?}
  end
end
