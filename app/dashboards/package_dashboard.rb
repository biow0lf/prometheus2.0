require "administrate/base_dashboard"

class PackageDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    srpm: Field::BelongsTo,
    group: Field::BelongsTo,
    requires: Field::HasMany,
    provides: Field::HasMany,
    obsoletes: Field::HasMany,
    conflicts: Field::HasMany,
    id: Field::Number,
    filename: Field::String,
    sourcepackage: Field::String,
    name: Field::String,
    version: Field::String,
    release: Field::String,
    arch: Field::String,
    summary: Field::String,
    license: Field::String,
    url: Field::String,
    description: Field::Text,
    buildtime: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    md5: Field::String,
    groupname: Field::String,
    size: Field::Number,
    epoch: Field::Number,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :srpm,
    :group,
    :requires,
    :provides,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :srpm,
    :group,
    :requires,
    :provides,
    :obsoletes,
    :conflicts,
    :id,
    :filename,
    :sourcepackage,
    :name,
    :version,
    :release,
    :arch,
    :summary,
    :license,
    :url,
    :description,
    :buildtime,
    :created_at,
    :updated_at,
    :md5,
    :groupname,
    :size,
    :epoch,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :srpm,
    :group,
    :requires,
    :provides,
    :obsoletes,
    :conflicts,
    :filename,
    :sourcepackage,
    :name,
    :version,
    :release,
    :arch,
    :summary,
    :license,
    :url,
    :description,
    :buildtime,
    :md5,
    :groupname,
    :size,
    :epoch,
  ]

  # Overwrite this method to customize how packages are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(package)
  #   "Package ##{package.id}"
  # end
end
