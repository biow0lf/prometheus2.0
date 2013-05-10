class MiscController < ApplicationController
  def bugs
    @bug_statuses = Bug.unscoped.select("DISTINCT bug_status").order("bugs.bug_status ASC").load
    @resolutions = Bug.unscoped.select("DISTINCT resolution").order("bugs.resolution ASC").load
    @bugs = Bug.unscoped.select("bug_status, resolution")
  end
end
