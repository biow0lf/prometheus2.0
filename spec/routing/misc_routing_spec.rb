require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MiscController, type: :routing do
  describe 'routing' do
    it 'should route /misc/bugs to misc#bugs' do
      expect({ get: '/misc/bugs' }).to route_to(controller: 'misc',
                                                action: 'bugs')
    end

    it 'should route /en/misc/bugs to misc#bugs' do
      expect({ get: '/en/misc/bugs' }).to route_to(controller: 'misc',
                                                   action: 'bugs',
                                                   locale: 'en')
    end
  end
end
