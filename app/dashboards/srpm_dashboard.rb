require "administrate/base_dashboard"

class SrpmDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    branch: Field::BelongsTo,
    group: Field::BelongsTo,
    packages: Field::HasMany,
    changelogs: Field::HasMany,
    specfile: Field::HasOne,
    patches: Field::HasMany,
    sources: Field::HasMany,
    repocops: Field::HasMany,
    repocop_patch: Field::HasOne,
    builder: Field::HasOne,
    gears: Field::HasMany,
    id: Field::Number,
    filename: Field::String,
    name: Field::String,
    version: Field::String,
    release: Field::String,
    summary: Field::String,
    license: Field::String,
    url: Field::String,
    description: Field::Text,
    buildtime: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    repocop: Field::String,
    vendor: Field::String,
    distribution: Field::String,
    changelogname: Field::String,
    changelogtext: Field::Text,
    md5: Field::String,
    delta: Field::Boolean,
    builder_id: Field::Number,
    groupname: Field::String,
    size: Field::Number,
    changelogtime: Field::DateTime,
    epoch: Field::Number,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :branch,
    :group,
    :packages,
    :changelogs,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :branch,
    :group,
    :packages,
    :changelogs,
    :specfile,
    :patches,
    :sources,
    :repocops,
    :repocop_patch,
    :builder,
    :gears,
    :id,
    :filename,
    :name,
    :version,
    :release,
    :summary,
    :license,
    :url,
    :description,
    :buildtime,
    :created_at,
    :updated_at,
    :repocop,
    :vendor,
    :distribution,
    :changelogname,
    :changelogtext,
    :md5,
    :delta,
    :builder_id,
    :groupname,
    :size,
    :changelogtime,
    :epoch,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :branch,
    :group,
    :packages,
    :changelogs,
    :specfile,
    :patches,
    :sources,
    :repocops,
    :repocop_patch,
    :builder,
    :gears,
    :filename,
    :name,
    :version,
    :release,
    :summary,
    :license,
    :url,
    :description,
    :buildtime,
    :repocop,
    :vendor,
    :distribution,
    :changelogname,
    :changelogtext,
    :md5,
    :delta,
    :builder_id,
    :groupname,
    :size,
    :changelogtime,
    :epoch,
  ]

  # Overwrite this method to customize how srpms are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(srpm)
  #   "Srpm ##{srpm.id}"
  # end
end
