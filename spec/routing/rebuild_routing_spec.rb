require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RebuildController, type: :routing do
  describe 'routing' do
    it 'should route /rebuild to rebuild#index' do
      expect({ get: '/rebuild' }).to route_to(controller: 'rebuild',
                                              action: 'index')
    end

    it 'should route /en/rebuild to rebuild#index' do
      expect({ get: '/en/rebuild' }).to route_to(controller: 'rebuild',
                                                 action: 'index',
                                                 locale: 'en')
    end
  end
end
