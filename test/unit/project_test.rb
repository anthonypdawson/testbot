require File.dirname(__FILE__) + '/../test_helper'

class ProjectTest < Test::Unit::TestCase
  fixtures :projects
  fixtures :test_suites
  fixtures :snippets

  def test_save
    assert projects(:first).is_a?(Project)
    p = Project.new :name=>projects(:first).name, :version=>projects(:first).version
    assert p.is_a?(Project)
    p = Project.new
    assert !p.save
    p.name = projects(:first).name
    p.version = projects(:first).version
    assert !p.save
    p.name = "Test Name"
    assert p.save
    p.version = "version"
    assert p.update
    assert p.destroy
  end

  def test_relationships
    pFirst = projects(:first)
    assert !pFirst.snippets.nil?
    assert !pFirst.test_suites.nil?
    pFirst.snippets << snippets(:first)
    pFirst.test_suites << test_suites(:first)
    assert pFirst.update
    assert pFirst.snippets.first.is_a?(Snippet)
    assert pFirst.test_suites.first.is_a?(TestSuite)
    assert pFirst.destroy
  end

  def test_methods
    pSecond = projects(:second)
    assert pSecond.to_s == "#{pSecond.name} v#{pSecond.version}"
  end
end
