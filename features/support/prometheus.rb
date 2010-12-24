Before do
  Branch.create!(:vendor => 'ALT Linux', :name => 'Sisyphus', :order_id => 0)
  Maintainer.create!(:name => 'Igor Zubkov', :email => 'icesik@altlinux.org', :login => 'icesik', :team => false)
end
