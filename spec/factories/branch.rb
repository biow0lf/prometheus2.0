FactoryGirl.define do
  factory :branch do
    name { "#{ Faker::Lorem.word.capitalize }" }
    vendor { Faker::Company.name }
    sequence(:order_id, 0) { |n| "#{ n }" }
    # path '/Somewhere'
    # srpm_dir ['/ALT/Sisyphus/files/SRPMS/']
    # rpm_dir ['/ALT/Sisyphus/files/i586/RPMS/*.i586.rpm',
    #           '/ALT/Sisyphus/files/noarch/RPMS/*.noarch.rpm',
    #           '/ALT/Sisyphus/files/x86_64/RPMS/*.x86_64.rpm']
  end
end
