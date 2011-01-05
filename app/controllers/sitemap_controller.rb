class SitemapController < ApplicationController
  layout nil

  def sitemap
    headers['Content-Type'] = 'application/xml'
  end

  def sitemap_basic
    headers['Content-Type'] = 'application/xml'
  end

  def sitemap_part1
    headers['Content-Type'] = 'application/xml'

    @srpms = Srpm.all(:select => 'name',
                      :order => 'srpms.name ASC',
                      :limit => 5000,
                      :conditions => { :branch_id => @branch.id })
  end

  def sitemap_part2
    headers['Content-Type'] = 'application/xml'

    @srpms = Srpm.all(:select => 'name',
                      :order => 'srpms.name ASC',
                      :limit => 5000,
                      :offset => 5000,
                      :conditions => { :branch_id => @branch.id })
  end

  def sitemap_part3
    headers['Content-Type'] = 'application/xml'

    @srpms = Srpm.all(:select => 'name',
                      :order => 'srpms.name ASC',
                      :limit => 5000,
                      :offset => 10000,
                      :conditions => { :branch_id => @branch.id })
  end
end