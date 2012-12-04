require 'rubygems'
require_gem 'mysql'
require_gem 'activerecord'
#Create an instance of AR Connection
class ActiveRecord::Base
  def self.connect(dbname, user, pass, ip, adapter)
    self.establish_connection(
      :adapter  => adapter,
      :host     => ip,
      :username => user,
      :password => pass,
      :database => dbname
    )
  end
  # Connect to specific DB (development, test or production)
  def self.connect_to_testbot(db)
    ActiveRecord::Base.connect(db,"root","","localhost","mysql")
    #Force a reconnect before mysql can dump us
    ActiveRecord::Base.verification_timeout = 14400
    #Manually set the mysql adapter to automatically reconnect!
    ActiveRecord::Base.connection.instance_eval {@connection.reconnect = true}
  end
end

