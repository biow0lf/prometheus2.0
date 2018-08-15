FactoryBot.define do
  factory :branch_path do
    arch { %w(i586 x86_64 noarch aarch64 mipsel armh)[rand(6)] }
    path { Dir.mktmpdir("#{@instance.arch}/#{@cached_attributes[:branchname]}") }

    branch nil

    transient do
      branchname { Faker::App.name }
    end

    after(:build) do |o, e|
      o.branch ||= create(:branch, name: e.branchname)

      if o.arch != "src"
         o.source_path ||= BranchPath.source.first || build(:src_branch_path, branchname: e.branchname)
      end
    end
  end

  factory :src_branch_path, parent: :branch_path do
    arch "src"
    path { Dir.mktmpdir(@cached_attributes[:branchname]) }
  end
end
