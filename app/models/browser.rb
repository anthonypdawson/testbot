# Represents a browser available on a selenium server
class Browser < ActiveRecord::Base
  has_and_belongs_to_many :selenium_servers
  has_many :results

  validates_presence_of :name, :selenium_name
  validates_uniqueness_of :name
end
