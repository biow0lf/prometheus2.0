FactoryBot.define do
  factory :branch_path do
    arch { %w(i586 x86_64 noarch aarch64 mipsel armh)[rand(6)] }
    path '/path/to/arch'

    branch nil
  end
end
