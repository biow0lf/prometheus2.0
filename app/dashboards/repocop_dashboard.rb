require "administrate/base_dashboard"

class RepocopDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    branch: Field::BelongsTo,
    id: Field::Number,
    name: Field::String,
    version: Field::String,
    release: Field::String,
    arch: Field::String,
    srcname: Field::String,
    srcversion: Field::String,
    srcrel: Field::String,
    testname: Field::String,
    status: Field::String,
    message: Field::Text,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :branch,
    :id,
    :name,
    :version,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :branch,
    :id,
    :name,
    :version,
    :release,
    :arch,
    :srcname,
    :srcversion,
    :srcrel,
    :testname,
    :status,
    :message,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :branch,
    :name,
    :version,
    :release,
    :arch,
    :srcname,
    :srcversion,
    :srcrel,
    :testname,
    :status,
    :message,
  ]

  # Overwrite this method to customize how repocops are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(repocop)
  #   "Repocop ##{repocop.id}"
  # end
end
