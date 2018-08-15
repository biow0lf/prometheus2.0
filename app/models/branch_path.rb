class BranchPath < ApplicationRecord
  belongs_to :branch
  belongs_to :source_path, foreign_key: :source_path_id, class_name: :BranchPath, optional: true

  has_many :named_srpms
  has_many :srpms, through: :named_srpms, counter_cache: :srpms_count

  scope :source, -> { where(arch: "src") }
  scope :package, -> { where.not(arch: "src") }
  scope :active, -> { where(active: true) }
  scope :phys, -> { where.not(arch: %w(src noarch)) }
  scope :unanonimous, -> { where.not(name: nil) }
  scope :for_branch, ->(branch) { where(branch_id: branch) }

  validates_presence_of :branch, :arch, :path
  validates_presence_of :source_path, if: -> { arch != "src" }
  validates_inclusion_of :arch, in: %w(i586 x86_64 aarch64 mipsel armh arm src noarch)

  validate :validate_path_existence

  def glob
    "*.#{arch}.rpm"
  end

  def empty?
    srpms_count == 0
  end

  protected

  def validate_path_existence
     if self.path && !File.directory?(self.path)
        self.errors.add(:path, "#{self.path} is not exist or folder")
     end
  end
end
