Fabricator(:group) do
  name 'Graphical desktop'
  parent_id nil
  branch { Fabricate(:branch) }
end
