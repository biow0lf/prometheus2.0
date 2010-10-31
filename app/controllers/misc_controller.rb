class MiscController < ApplicationController
  def bugs
    @bug_statuses = Bug.where("").select("DISTINCT bug_status").all
    @resolutions = Bug.where("").select("DISTINCT resolution").all
    @bugs = Bug.where("").select("bug_status","resolution")
  end
end