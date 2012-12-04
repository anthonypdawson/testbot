class Revision < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :version, :project_id, :is_current

  def current?
    return self.is_current
  end

end
