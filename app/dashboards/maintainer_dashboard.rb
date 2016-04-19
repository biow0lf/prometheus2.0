require "administrate/base_dashboard"

class MaintainerDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    teams: Field::HasMany,
    gears: Field::HasMany,
    ftbfs: Field::HasMany.with_options(class_name: "Ftbfs"),
    id: Field::Number,
    name: Field::String,
    email: Field::String,
    login: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    time_zone: Field::String,
    jabber: Field::String,
    info: Field::Text,
    website: Field::String,
    location: Field::String,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :teams,
    :gears,
    :ftbfs,
    :id,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :teams,
    :gears,
    :ftbfs,
    :id,
    :name,
    :email,
    :login,
    :created_at,
    :updated_at,
    :time_zone,
    :jabber,
    :info,
    :website,
    :location,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :teams,
    :gears,
    :ftbfs,
    :name,
    :email,
    :login,
    :time_zone,
    :jabber,
    :info,
    :website,
    :location,
  ]

  # Overwrite this method to customize how maintainers are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(maintainer)
  #   "Maintainer ##{maintainer.id}"
  # end
end
