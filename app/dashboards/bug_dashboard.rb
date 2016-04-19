require "administrate/base_dashboard"

class BugDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    bug_id: Field::Number,
    bug_status: Field::String,
    resolution: Field::String,
    bug_severity: Field::String,
    product: Field::String,
    component: Field::String,
    assigned_to: Field::String,
    reporter: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    short_desc: Field::Text,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :bug_id,
    :bug_status,
    :resolution,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :bug_id,
    :bug_status,
    :resolution,
    :bug_severity,
    :product,
    :component,
    :assigned_to,
    :reporter,
    :created_at,
    :updated_at,
    :short_desc,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :bug_id,
    :bug_status,
    :resolution,
    :bug_severity,
    :product,
    :component,
    :assigned_to,
    :reporter,
    :short_desc,
  ]

  # Overwrite this method to customize how bugs are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(bug)
  #   "Bug ##{bug.id}"
  # end
end
