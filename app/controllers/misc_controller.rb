# encoding: utf-8

class MiscController < ApplicationController
  def bugs
    @bug_statuses = Bug.unscoped.select("DISTINCT bug_status").order("bugs.bug_status ASC").all
    @resolutions = Bug.unscoped.select("DISTINCT resolution").order("bugs.resolution ASC").all
    @bugs = Bug.unscoped.select("bug_status, resolution")
  end
end
