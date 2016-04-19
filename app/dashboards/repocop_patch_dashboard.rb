require "administrate/base_dashboard"

class RepocopPatchDashboard < Administrate::BaseDashboard
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
    url: Field::String,
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
    :url,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :branch,
    :name,
    :version,
    :release,
    :url,
  ]

  # Overwrite this method to customize how repocop patches are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(repocop_patch)
  #   "RepocopPatch ##{repocop_patch.id}"
  # end
end
