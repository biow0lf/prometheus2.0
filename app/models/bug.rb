class Bug < ActiveRecord::Base
  validates :bug_id, presence: true

  class << self
    def opened_bugs_for(components)
      bug_statuses = %w(NEW ASSIGNED VERIFIED REOPENED)
      where(component: components, bug_status: bug_statuses).order('bug_id DESC')
    end

    def all_bugs_for(components)
      where(component: components).order('bug_id DESC')
    end
  end
end
