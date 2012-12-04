class Snippet < ActiveRecord::Base
  belongs_to :project
  validates_presence_of :name, :script
  validates_uniqueness_of :name

  def active?
    return self.is_active
  end

  def archive
    self.is_active = false
    self.save
  end
end
