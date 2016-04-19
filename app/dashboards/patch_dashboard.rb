require "administrate/base_dashboard"

class PatchDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    srpm: Field::BelongsTo,
    id: Field::Number,
    patch: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    filename: Field::String,
    size: Field::Number,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :srpm,
    :id,
    :patch,
    :created_at,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :srpm,
    :id,
    :patch,
    :created_at,
    :updated_at,
    :filename,
    :size,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :srpm,
    :patch,
    :filename,
    :size,
  ]

  # Overwrite this method to customize how patches are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(patch)
  #   "Patch ##{patch.id}"
  # end
end
