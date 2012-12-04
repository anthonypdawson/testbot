# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 37) do

  create_table "browsers", :force => true do |t|
    t.column "name",          :string,   :default => "",                    :null => false
    t.column "path",          :string
    t.column "created_on",    :datetime, :default => '2008-10-02 17:23:43'
    t.column "selenium_name", :string,   :default => "",                    :null => false
  end

  create_table "browsers_selenium_servers", :id => false, :force => true do |t|
    t.column "browser_id",         :integer, :null => false
    t.column "selenium_server_id", :integer, :null => false
  end

  create_table "browsers_test_suite_executions", :id => false, :force => true do |t|
    t.column "browser_id",              :integer, :null => false
    t.column "test_suite_execution_id", :integer, :null => false
  end

  create_table "environments", :force => true do |t|
    t.column "name",       :string,   :default => "",   :null => false
    t.column "project_id", :integer,                    :null => false
    t.column "base_url",   :string,   :default => "",   :null => false
    t.column "is_current", :boolean,  :default => true, :null => false
    t.column "created_on", :datetime,                   :null => false
  end

  create_table "projects", :force => true do |t|
    t.column "name",       :string,   :default => "",                    :null => false
    t.column "created_on", :datetime, :default => '2008-10-02 17:23:14', :null => false
  end

  create_table "results", :force => true do |t|
    t.column "created_on",              :datetime, :default => '2008-10-02 17:23:43', :null => false
    t.column "failures",                :text
    t.column "successes",               :text
    t.column "test_suite_id",           :integer
    t.column "test_case_id",            :integer,                                     :null => false
    t.column "browser_id",              :integer,                                     :null => false
    t.column "test_suite_execution_id", :integer,                                     :null => false
    t.column "project_id",              :integer,                                     :null => false
  end

  create_table "revisions", :force => true do |t|
    t.column "version",    :string,   :default => "",   :null => false
    t.column "project_id", :integer,                    :null => false
    t.column "created_on", :datetime,                   :null => false
    t.column "is_current", :boolean,  :default => true, :null => false
  end

  create_table "selenium_servers", :force => true do |t|
    t.column "name",       :string,   :default => "",                    :null => false
    t.column "host_name",  :string,   :default => "",                    :null => false
    t.column "port",       :integer,  :default => 4444,                  :null => false
    t.column "created_on", :datetime, :default => '2008-10-02 17:23:43', :null => false
    t.column "is_active",  :boolean,  :default => true,                  :null => false
  end

  create_table "snippets", :force => true do |t|
    t.column "name",       :string,  :limit => 64, :default => "",   :null => false
    t.column "script",     :text,                  :default => "",   :null => false
    t.column "project_id", :integer
    t.column "is_active",  :boolean,               :default => true, :null => false
  end

  create_table "test_cases", :force => true do |t|
    t.column "name",            :string,   :default => "",                    :null => false
    t.column "test_link_id",    :integer
    t.column "setup_script",    :text
    t.column "teardown_script", :text
    t.column "execute_script",  :text,     :default => "",                    :null => false
    t.column "created_on",      :datetime, :default => '2008-10-02 17:23:14', :null => false
    t.column "project_id",      :integer,                                     :null => false
  end

  create_table "test_cases_test_suite_executions", :id => false, :force => true do |t|
    t.column "test_case_id",            :integer, :null => false
    t.column "test_suite_execution_id", :integer, :null => false
  end

  create_table "test_cases_test_suites", :id => false, :force => true do |t|
    t.column "test_case_id",  :integer, :null => false
    t.column "test_suite_id", :integer, :null => false
  end

  create_table "test_suite_executions", :force => true do |t|
    t.column "status",             :string,   :limit => 1,  :default => "n",                   :null => false
    t.column "created_on",         :datetime,               :default => '2008-10-02 17:23:43', :null => false
    t.column "selenium_server_id", :integer,                                                   :null => false
    t.column "project_id",         :integer,                                                   :null => false
    t.column "started_on",         :datetime
    t.column "completed_on",       :datetime
    t.column "description",        :string,   :limit => 64
    t.column "environment_id",     :integer,                                                   :null => false
    t.column "revision_id",        :integer,                                                   :null => false
    t.column "is_test",            :boolean,                :default => false,                 :null => false
  end

  create_table "test_suite_executions_test_suites", :id => false, :force => true do |t|
    t.column "test_suite_execution_id", :integer, :null => false
    t.column "test_suite_id",           :integer, :null => false
  end

  create_table "test_suites", :force => true do |t|
    t.column "name",       :string,   :default => "",                    :null => false
    t.column "created_on", :datetime, :default => '2008-10-02 17:23:14', :null => false
    t.column "project_id", :integer
    t.column "is_active",  :boolean,  :default => true,                  :null => false
  end

end