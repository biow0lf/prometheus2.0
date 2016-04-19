require "administrate/base_dashboard"

class RequireDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    package: Field::BelongsTo,
    id: Field::Number,
    name: Field::String,
    version: Field::String,
    release: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    epoch: Field::String,
    flags: Field::Number,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :package,
    :id,
    :name,
    :version,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :package,
    :id,
    :name,
    :version,
    :release,
    :created_at,
    :updated_at,
    :epoch,
    :flags,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :package,
    :name,
    :version,
    :release,
    :epoch,
    :flags,
  ]

  # Overwrite this method to customize how requires are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(require)
  #   "Require ##{require.id}"
  # end
end
