class BranchPath < ApplicationRecord
  belongs_to :branch

  validates_presence_of :branch, :arch, :path
  validates_inclusion_of :arch, in: %w(i586 x86_64 noarch aarch64 mipsel armh)
end
