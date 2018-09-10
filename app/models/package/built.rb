# frozen_string_literal: true

class Package::Built < Package
   belongs_to :src, class_name: 'Package::Src'

   has_many :requires, inverse_of: :package, dependent: :destroy
   has_many :provides, inverse_of: :package,dependent: :destroy
   has_many :obsoletes, inverse_of: :package,dependent: :destroy
   has_many :conflicts, inverse_of: :package,dependent: :destroy
end
