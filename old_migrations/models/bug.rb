class Bug < ActiveRecord::Base
  validates_presence_of :bug_id, :bug_status, :bug_severity, :product, :component, :assigned_to, :reporter, :short_desc
end
