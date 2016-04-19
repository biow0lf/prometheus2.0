require "administrate/base_dashboard"

class MirrorDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    branch: Field::BelongsTo,
    id: Field::Number,
    order_id: Field::Number,
    name: Field::String,
    country: Field::String,
    uri: Field::String,
    protocol: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :branch,
    :id,
    :order_id,
    :name,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :branch,
    :id,
    :order_id,
    :name,
    :country,
    :uri,
    :protocol,
    :created_at,
    :updated_at,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :branch,
    :order_id,
    :name,
    :country,
    :uri,
    :protocol,
  ]

  # Overwrite this method to customize how mirrors are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(mirror)
  #   "Mirror ##{mirror.id}"
  # end
end
