require File.expand_path(File.dirname(__FILE__) + '/../rails_helper')

describe 'rsync routing' do
  it 'should route /rsync/new to rsync#new' do
    expect(get: '/rsync/new').to route_to('rsync#new')
  end

  it 'should route /:locale/rsync/new to rsync#new' do
    expect(get: '/en/rsync/new').to route_to(
      controller: 'rsync',
      action: 'new',
      locale: 'en'
    )
  end
end
