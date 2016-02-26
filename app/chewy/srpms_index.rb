class SrpmsIndex < Chewy::Index
  define_type Srpm do
    # branch?
    field :name
    field :summary
    field :description
    field :filename
    field :url
    field :packages do
      field :name
      field :summary
      field :description
      field :filename
      field :sourcepackage
    end
  end
end
