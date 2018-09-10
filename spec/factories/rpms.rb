FactoryBot.define do
   factory :rpm do
      filename { "#{name || Faker::App.name}-#{Faker::App.semantic_version}-#{'alt' + Faker::App.semantic_version}.#{arch}.rpm" }
      package { build(:package, arch.to_sym, name: filename.split('-')[0...-2].join('-'), group: group) }

      transient do
         arch { %w(i586 x86_64 noarch aarch64 mipsel armh)[rand(6)] }
         name nil
         branchname { Faker::App.name }
         branch nil
         group { build(:group) }
      end

      after(:build) do |o, e|
         if e.arch != 'src'
            if e.branch
               o.branch_path ||= e.branch.branch_paths.built.first
            elsif e.branchname
               o.branch_path ||= Branch.where(name: e.branchname).first&.branch_paths&.built&.first ||
                                 create(:branch_path, branchname: e.branchname)
            else
               o.branch_path ||= create(:branch_path)
            end
         end
      end
   end
   
   factory :srpm, parent: :rpm do
      transient do
         arch 'src'
      end

      after(:build) do |o, e|
         if e.branch
            o.branch_path ||= e.branch.branch_paths.src.first
         elsif e.branchname
            o.branch_path ||= Branch.where(name: e.branchname).first&.branch_paths&.src&.first ||
                              create(:src_branch_path, branchname: e.branchname)
         else
            o.branch_path ||= create(:src_branch_path)
         end
      end
   end
end
