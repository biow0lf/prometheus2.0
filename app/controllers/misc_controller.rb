class MiscController < ApplicationController
  def bugs
    @bug_statuses = Bug.select("DISTINCT bug_status").order("bugs.bug_status ASC")
    @resolutions = Bug.select("DISTINCT resolution").order("bugs.resolution ASC")
    @bugs = Bug.unscoped.select("bug_status, resolution")
  end
end
