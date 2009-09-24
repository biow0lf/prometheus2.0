xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Sisyphus 2.0"
    xml.description "Sisyphus 2.0"
    xml.link '/'

    for post in @reports
      xml.item do
        xml.title post.name + ' ' + post.testname + ' ' + post.status
        xml.description post.message
        xml.pubDate Time.now.to_s(:rfc822)
        xml.link '/srpm/Sisyphus/' + post.name + '/repocop'
      end
    end
  end
end
