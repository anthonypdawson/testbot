class Environment < ActiveRecord::Base
  TYPES = ["Development", "Stage", "Production", "Other"]
  belongs_to :project

  validates_presence_of :project_id, :base_url, :is_current, :name

  def validate
    errors.add(:environment_name, "Please give a valid name") if self.name == "Name"
    errors.add(:environment_base_url, "Please give a valid Base URL") if self.base_url == "Base URL"
  end

  def to_s
    "#{self.name} - #{self.base_url}"
  end

  def current?
    return self.is_current
  end

end
