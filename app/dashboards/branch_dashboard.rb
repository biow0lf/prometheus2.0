require "administrate/base_dashboard"

class BranchDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    vendor: Field::String,
    name: Field::String,
    order_id: Field::Number,
    path: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    # :srpms,
    # :changelogs,
    # :packages,
    # :groups,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    # :srpms,
    # :changelogs,
    # :packages,
    # :groups,
    # :teams,
    # :mirrors,
    # :patches,
    # :sources,
    # :ftbfs,
    # :repocops,
    # :repocop_patches,
    :id,
    :vendor,
    :name,
    :order_id,
    :path,
    :created_at,
    :updated_at,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    # :srpms,
    # :changelogs,
    # :packages,
    # :groups,
    # :teams,
    # :mirrors,
    # :patches,
    # :sources,
    # :ftbfs,
    # :repocops,
    # :repocop_patches,
    :vendor,
    :name,
    :order_id,
    :path,
  ]

  # Overwrite this method to customize how branches are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(branch)
  #   "Branch ##{branch.id}"
  # end
end
