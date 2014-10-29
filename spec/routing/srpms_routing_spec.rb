require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SrpmsController, type: :routing do
  describe 'routing' do
    it 'should route /Sisyphus/srpms/glibc to srpms#show' do
      expect({ get: '/Sisyphus/srpms/glibc' }).to route_to(controller: 'srpms',
                                                           action: 'show',
                                                           branch: 'Sisyphus',
                                                           id: 'glibc')
    end

    it 'should route /en/Sisyphus/srpms/glibc to srpms#show' do
      expect({ get: '/en/Sisyphus/srpms/glibc' }).to route_to(controller: 'srpms',
                                                              action: 'show',
                                                              branch: 'Sisyphus',
                                                              id: 'glibc',
                                                              locale: 'en')
    end

    it 'should route /Sisyphus/srpms/glibc/changelog to srpms#show' do
      expect({ get: '/Sisyphus/srpms/glibc/changelog' }).to route_to(:controller => 'srpms',
                                                                     :action => 'changelog',
                                                                     :branch => 'Sisyphus',
                                                                     :id => 'glibc')
    end

    it 'should route /en/Sisyphus/srpms/glibc/changelog to srpms#changelog' do
      expect({ get: '/en/Sisyphus/srpms/glibc/changelog' }).to route_to(controller: 'srpms',
                                                                        action: 'changelog',
                                                                        branch: 'Sisyphus',
                                                                        id: 'glibc',
                                                                        locale: 'en')
    end

    it 'should route /Sisyphus/srpms/glibc/spec to srpms#spec' do
      expect({ get: '/Sisyphus/srpms/glibc/spec' }).to route_to(controller: 'srpms',
                                                                action: 'spec',
                                                                branch: 'Sisyphus',
                                                                id: 'glibc')
    end

    it 'should route /en/Sisyphus/srpms/glibc/spec to srpms#spec' do
      expect({ get: '/en/Sisyphus/srpms/glibc/spec' }).to route_to(controller: 'srpms',
                                                                   action: 'spec',
                                                                   branch: 'Sisyphus',
                                                                   id: 'glibc',
                                                                   locale: 'en')
    end

    it 'should route /Sisyphus/srpms/glibc/rawspec to srpms#rawspec' do
      expect({ get: '/Sisyphus/srpms/glibc/rawspec' }).to route_to(controller: 'srpms',
                                                                   action: 'rawspec',
                                                                   branch: 'Sisyphus',
                                                                   id: 'glibc')
    end

    it 'should route /en/Sisyphus/srpms/glibc/rawspec to srpms#rawspec' do
      expect({ get: '/en/Sisyphus/srpms/glibc/rawspec' }).to route_to(controller: 'srpms',
                                                                      action: 'rawspec',
                                                                      branch: 'Sisyphus',
                                                                      id: 'glibc',
                                                                      locale: 'en')
    end

    it 'should route /Sisyphus/srpms/glibc/get to srpms#get' do
      expect({ get: '/Sisyphus/srpms/glibc/get' }).to route_to(controller: 'srpms',
                                                               action: 'get',
                                                               branch: 'Sisyphus',
                                                               id: 'glibc')
    end

    it 'should route /en/Sisyphus/srpms/glibc/get to srpms#get' do
      expect({ get: '/en/Sisyphus/srpms/glibc/get' }).to route_to(controller: 'srpms',
                                                                  action: 'get',
                                                                  branch: 'Sisyphus',
                                                                  id: 'glibc',
                                                                  locale: 'en')
    end

    it 'should route /Sisyphus/srpms/glibc/gear to srpms#gear' do
      expect({ get: '/Sisyphus/srpms/glibc/gear' }).to route_to(controller: 'srpms',
                                                                action: 'gear',
                                                                branch: 'Sisyphus',
                                                                id: 'glibc')
    end

    it 'should route /en/Sisyphus/srpms/glibc/gear to srpms#gear' do
      expect({ get: '/en/Sisyphus/srpms/glibc/gear' }).to route_to(controller: 'srpms',
                                                                   action: 'gear',
                                                                   branch: 'Sisyphus',
                                                                   id: 'glibc',
                                                                   locale: 'en')
    end

    it 'should route /Sisyphus/srpms/glibc/bugs to srpms#bugs' do
      expect({ get: '/Sisyphus/srpms/glibc/bugs' }).to route_to(controller: 'srpms',
                                                                action: 'bugs',
                                                                id: 'glibc')
    end

    it 'should route /en/Sisyphus/srpms/glibc/bugs to srpms#bugs' do
      expect({ get: '/en/Sisyphus/srpms/glibc/bugs' }).to route_to(controller: 'srpms',
                                                                   action: 'bugs',
                                                                   id: 'glibc',
                                                                   locale: 'en')
    end

    it 'should route /Sisyphus/srpms/glibc/allbugs to srpms#allbugs' do
      expect({ get: '/Sisyphus/srpms/glibc/allbugs' }).to route_to(controller: 'srpms',
                                                                   action: 'allbugs',
                                                                   id: 'glibc')
    end

    it 'should route /en/Sisyphus/srpms/glibc/allbugs to srpms#allbugs' do
      expect({ get: '/en/Sisyphus/srpms/glibc/allbugs' }).to route_to(controller: 'srpms',
                                                                      action: 'allbugs',
                                                                      id: 'glibc',
                                                                      locale: 'en')
    end

    it 'should route /Sisyphus/srpms/glibc/repocop to srpms#repocop' do
      expect({ get: '/Sisyphus/srpms/glibc/repocop' }).to route_to(controller: 'srpms',
                                                                   action: 'repocop',
                                                                   id: 'glibc')
    end

    it 'should route /en/Sisyphus/srpms/glibc/repocop to srpms#repocop' do
      expect({ get: '/en/Sisyphus/srpms/glibc/repocop' }).to route_to(controller: 'srpms',
                                                                      action: 'repocop',
                                                                      id: 'glibc',
                                                                      locale: 'en')
    end
  end
end
