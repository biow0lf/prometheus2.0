require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RsyncController, type: :routing do
  describe 'routing' do
    it 'should route /rsync/new to rsync#new' do
      expect(get: '/rsync/new').to route_to(controller: 'rsync',
                                            action: 'new')
    end

    it 'should route /en/rsync/new to rsync#new' do
      expect(get: '/en/rsync/new').to route_to(controller: 'rsync',
                                               action: 'new',
                                               locale: 'en')
    end
  end
end
