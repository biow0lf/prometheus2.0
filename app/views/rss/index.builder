xml.instruct!
xml.rss "version" => "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "Fresh packages in #{@branch.name}"
    xml.link url_for(:only_path => false, :controller => 'home', :action => 'index')
    xml.description "Fresh packages in #{@branch.name}"
    xml.ttl 60
    for srpm in @srpms do
      xml.item do
        xml.title "#{srpm.name}-#{srpm.version}-#{srpm.release}"
        xml.link url_for(:only_path => false, :controller => 'srpms', :action => 'show', :id => srpm.name, :branch => @branch.name)
        xml.description simple_format(srpm.changelogtext)
        xml.guid "#{srpm.name}-#{srpm.epoch ? srpm.epoch + ':' : ''}#{srpm.version}-#{srpm.release}", :isPermaLink => false
      end
    end
  end
end
