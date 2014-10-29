require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MaintainersController, type: :routing do
  describe 'routing' do
    it 'should route /Sisyphus/maintainers/icesik to maintainers#show' do
      expect({ get: '/Sisyphus/maintainers/icesik' }).to route_to(controller: 'maintainers',
                                                                  action: 'show',
                                                                  branch: 'Sisyphus',
                                                                  id: 'icesik')
    end

    it 'should route /en/Sisyphus/maintainers/icesik to maintainers#show' do
      expect({ get: '/en/Sisyphus/maintainers/icesik' }).to route_to(controller: 'maintainers',
                                                                     action: 'show',
                                                                     branch: 'Sisyphus',
                                                                     id: 'icesik',
                                                                     locale: 'en')
    end

    it 'should route /Sisyphus/maintainers/icesik/srpms to maintainers#srpms' do
      expect({ get: '/Sisyphus/maintainers/icesik/srpms' }).to route_to(controller: 'maintainers',
                                                                        action: 'srpms',
                                                                        branch: 'Sisyphus',
                                                                        id: 'icesik')
    end

    it 'should route /en/Sisyphus/maintainers/icesik/srpms to maintainers#srpms' do
      expect({ get: '/en/Sisyphus/maintainers/icesik/srpms' }).to route_to(controller: 'maintainers',
                                                                           action: 'srpms',
                                                                           branch: 'Sisyphus',
                                                                           id: 'icesik',
                                                                           locale: 'en')
    end

    it 'should route /Sisyphus/maintainers/icesik/gear to maintainers#gear' do
      expect({ get: '/Sisyphus/maintainers/icesik/gear' }).to route_to(controller: 'maintainers',
                                                                       action: 'gear',
                                                                       id: 'icesik')
    end

    it 'should route /en/Sisyphus/maintainers/icesik/gear to maintainers#gear' do
      expect({ get: '/en/Sisyphus/maintainers/icesik/gear' }).to route_to(controller: 'maintainers',
                                                                          action: 'gear',
                                                                          id: 'icesik',
                                                                          locale: 'en')
    end

    it 'should route /Sisyphus/maintainers/icesik/bugs to maintainers#bugs' do
      expect({ get: '/Sisyphus/maintainers/icesik/bugs' }).to route_to(controller: 'maintainers',
                                                                       action: 'bugs',
                                                                       id: 'icesik')
    end

    it 'should route /en/Sisyphus/maintainers/icesik/bugs to maintainers#bugs' do
      expect({ get: '/en/Sisyphus/maintainers/icesik/bugs' }).to route_to(controller: 'maintainers',
                                                                          action: 'bugs',
                                                                          id: 'icesik',
                                                                          locale: 'en')
    end

    it 'should route /Sisyphus/maintainers/icesik/allbugs to maintainers#allbugs' do
      expect({ get: '/Sisyphus/maintainers/icesik/allbugs' }).to route_to(controller: 'maintainers',
                                                                          action: 'allbugs',
                                                                          id: 'icesik')
    end

    it 'should route /en/Sisyphus/maintainers/icesik/allbugs to maintainers#allbugs' do
      expect({ get: '/en/Sisyphus/maintainers/icesik/allbugs' }).to route_to(controller: 'maintainers',
                                                                             action: 'allbugs',
                                                                             id: 'icesik',
                                                                             locale: 'en')
    end

    it 'should route /Sisyphus/maintainers/icesik/ftbfs to maintainers#ftbfs' do
      expect({ get: '/Sisyphus/maintainers/icesik/ftbfs' }).to route_to(controller: 'maintainers',
                                                                        action: 'ftbfs',
                                                                        id: 'icesik')
    end

    it 'should route /en/Sisyphus/maintainers/icesik/ftbfs to maintainers#ftbfs' do
      expect({ get: '/en/Sisyphus/maintainers/icesik/ftbfs' }).to route_to(controller: 'maintainers',
                                                                           action: 'ftbfs',
                                                                           id: 'icesik',
                                                                           locale: 'en')
    end

    it 'should route /Sisyphus/maintainers/icesik/repocop to maintainers#repocop' do
      expect({ get: '/Sisyphus/maintainers/icesik/repocop' }).to route_to(controller: 'maintainers',
                                                                          action: 'repocop',
                                                                          id: 'icesik')
    end

    it 'should route /en/Sisyphus/maintainers/icesik/repocop to maintainers#repocop' do
      expect({ get: '/en/Sisyphus/maintainers/icesik/repocop' }).to route_to(controller: 'maintainers',
                                                                             action: 'repocop',
                                                                             id: 'icesik',
                                                                             locale: 'en')
    end
  end
end
