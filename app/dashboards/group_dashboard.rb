require "administrate/base_dashboard"

class GroupDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    parent: Field::BelongsTo.with_options(class_name: "Group"),
    children: Field::HasMany.with_options(class_name: "Group"),
    branch: Field::BelongsTo,
    srpms: Field::HasMany,
    packages: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    parent_id: Field::Number,
    lft: Field::Number,
    rgt: Field::Number,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :parent,
    :children,
    :branch,
    :srpms,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :parent,
    :children,
    :branch,
    :srpms,
    :packages,
    :id,
    :name,
    :created_at,
    :updated_at,
    :parent_id,
    :lft,
    :rgt,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :parent,
    :children,
    :branch,
    :srpms,
    :packages,
    :name,
    :parent_id,
    :lft,
    :rgt,
  ]

  # Overwrite this method to customize how groups are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(group)
  #   "Group ##{group.id}"
  # end
end
