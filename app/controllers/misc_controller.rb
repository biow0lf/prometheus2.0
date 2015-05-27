class MiscController < ApplicationController
  def bugs
    @bug_statuses = Bug.select('DISTINCT bug_status').order('bug_status ASC')
    @resolutions = Bug.select('DISTINCT resolution').order('resolution ASC')
    @bugs = Bug.select('bug_status, resolution')
  end
end
