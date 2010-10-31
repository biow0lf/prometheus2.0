class MiscController < ApplicationController
  def bugs
    @bug_statuses = Bug.where("").select("DISTINCT bug_status").order("bug_status ASC").all
    @resolutions = Bug.where("").select("DISTINCT resolution").order("resolution ASC").all
    @bugs = Bug.where("").select("bug_status","resolution")
  end
end