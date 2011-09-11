xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title t("transit.rss.#{resource_instance_name.to_s.underscore}_feed_title")
    xml.description ""
    xml.link polymorphic_url(resource_class)

    for post in @resources
      xml.item do
        xml.title post.title
        xml.description strip_tags(post.teaser)
        xml.pubDate post.post_date.to_s(:rfc822)
        xml.link deliver_rss(post)
        xml.guid deliver_rss(post)
      end
    end
  end
end