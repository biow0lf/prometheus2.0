FactoryBot.define do
  factory :named_srpm do
    sequence(:name) { |n| "#{Faker::App.name.downcase}-#{n}" }
    srpm nil
    branch_path nil

    transient do
      branchname { Faker::App.name }
      branch nil
      group nil
    end

    after(:build) do |o, e|
      o.srpm ||= build(:srpm, group: e.group)

      if e.branch
        o.branch_path ||= e.branch.branch_paths.source.first
      elsif e.branchname
        o.branch_path ||= Branch.where(name: e.branchname).first&.branch_paths&.source&.first ||
                          create(:src_branch_path, branchname: e.branchname)
      else
        o.branch_path ||= create(:src_branch_path)
      end
    end
  end
end
