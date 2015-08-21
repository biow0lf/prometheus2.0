module Api
  class BugsController < ApplicationController
    def show
      @bug = Bug.find_by!(bug_id: params[:id]).decorate
    end
  end
end
