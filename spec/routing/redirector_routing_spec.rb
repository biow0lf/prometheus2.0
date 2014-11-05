require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RedirectorController, type: :routing do
  describe 'routing' do
    it 'should route /glibc to redirector#index' do
      expect(get: '/glibc').to route_to(controller: 'redirector',
                                        action: 'index',
                                        name: 'glibc')
    end

    it 'should route /src:glibc to redirector#index' do
      expect(get: '/src:glibc').to route_to(controller: 'redirector',
                                            action: 'index',
                                            name: 'src:glibc')
    end
  end
end
