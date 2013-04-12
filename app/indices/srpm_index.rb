ThinkingSphinx::Index.define :srpm, with: :active_record, delta: true do
  indexes name, sortable: true
  indexes summary
  indexes description
  indexes filename
  indexes url
  indexes packages.name, as: :packages_name, sortable: true
  indexes packages.summary, as: :packages_summary
  indexes packages.description, as: :packages_description
  indexes packages.filename, as: :packages_filename
  indexes packages.sourcepackage, as: :packages_sourcepackage

  has branch_id

  set_property :delta => true
end
