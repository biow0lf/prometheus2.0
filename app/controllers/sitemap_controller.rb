class SitemapController < ApplicationController
  layout nil

  def sitemap_basic
    headers['Content-Type'] = "application/xml"
  end

  def sitemap_full
    headers['Content-Type'] = "application/xml"
  end

  def sitemap_part1
    headers['Content-Type'] = "application/xml"

    @srpms = Srpm.all :select => 'name, branch, vendor',
                      :order => 'name ASC',
                      :limit => 5000,
                      :conditions => { :branch => 'Sisyphus',
                                       :vendor => 'ALT Linux' }
  end

  def sitemap_part2
    headers['Content-Type'] = "application/xml"

    @srpms = Srpm.all :select => 'name, branch, vendor',
                      :order => 'name ASC',
                      :limit => 5000,
                      :offset => 5000,
                      :conditions => { :branch => 'Sisyphus',
                                       :vendor => 'ALT Linux' }
  end

#  def sitemap_en1
#    headers['Content-Type'] = "application/xml"
#
#    @srpms = Srpm.all :select => 'name, branch, vendor',
#                      :order => 'name ASC',
#                      :limit => 5000,
#                      :conditions => { :branch => 'Sisyphus',
#                                       :vendor => 'ALT Linux' }
#  end
#
#  def sitemap_en2
#    headers['Content-Type'] = "application/xml"
#
#    @srpms = Srpm.all :select => 'name, branch, vendor',
#                      :order => 'name ASC',
#                      :limit => 5000,
#                      :offset => 5000,
#                      :conditions => { :branch => 'Sisyphus',
#                                       :vendor => 'ALT Linux' }
#  end
#
#  def sitemap_ru1
#    headers['Content-Type'] = "application/xml"
#
#    @srpms = Srpm.all :select => 'name, branch, vendor',
#                      :order => 'name ASC',
#                      :limit => 5000,
#                      :conditions => { :branch => 'Sisyphus',
#                                       :vendor => 'ALT Linux' }
#  end
#
#  def sitemap_ru2
#    headers['Content-Type'] = "application/xml"
#
#    @srpms = Srpm.all :select => 'name, branch, vendor',
#                      :order => 'name ASC',
#                      :limit => 5000,
#                      :offset => 5000,
#                      :conditions => { :branch => 'Sisyphus',
#                                       :vendor => 'ALT Linux' }
#  end
#
#  def sitemap_uk1
#    headers['Content-Type'] = "application/xml"
#
#    @srpms = Srpm.all :select => 'name, branch, vendor',
#                      :order => 'name ASC',
#                      :limit => 5000,
#                      :conditions => { :branch => 'Sisyphus',
#                                       :vendor => 'ALT Linux' }
#  end
#
#  def sitemap_uk2
#    headers['Content-Type'] = "application/xml"
#
#    @srpms = Srpm.all :select => 'name, branch, vendor',
#                      :order => 'name ASC',
#                      :limit => 5000,
#                      :offset => 5000,
#                      :conditions => { :branch => 'Sisyphus',
#                                       :vendor => 'ALT Linux' }
#  end

end
