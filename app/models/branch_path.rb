class BranchPath < ApplicationRecord
  belongs_to :branch
  belongs_to :source_path, foreign_key: :source_path_id, class_name: :BranchPath, optional: true

  has_many :named_srpms

  scope :source, -> { where(arch: "src") }
  scope :package, -> { where.not(arch: "src") }
  scope :active, -> { where(active: true) }
  scope :phys, -> { where.not(arch: %w(src noarch)) }

  validates_presence_of :branch, :arch, :path
  validates_presence_of :source_path, if: -> { arch != "src" }
  validates_inclusion_of :arch, in: %w(i586 x86_64 aarch64 mipsel armh src noarch)

  def glob
    File.join(path, "*.#{arch}.rpm")
  end
end
