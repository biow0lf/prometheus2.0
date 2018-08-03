# frozen_string_literal: true

module Admin
  class ArchitecturesController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Architecture.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Architecture.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    # Disable destroy
    def valid_action?(name, resource = resource_class)
      ['destroy'].exclude?(name.to_s) && super
    end
  end
end
