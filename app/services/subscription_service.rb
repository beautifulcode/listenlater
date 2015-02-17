class SubscriptionService

  def self.subscribe(url, uid)
    #TODO
    # Background this!
    #puts "Subscribing to #{url} with uid: #{uid}"
    service.subscribe(url, uid) do |result|
      puts "Subscribed to #{url}"  if result
    end
  end

  # XML
  def receive(payload, uid)
    #TODO
    # Background this!

    Rails.logger.info("The feed #{payload} has been fetched")
    series = Series.find_by_uid(uid)

    # Legacy data in superfeedr that points to sub vs seris
    series ||= Subscription.find(uid).series

    series.sources << parse_sources(payload)
    series.save

  end

  def parse_sources(payload)
    #Parsers::Basic.new(payload)

    puts "PAYLOAD: #{payload}"
    parse_entries_from(payload).collect do |entry|
      attrs = extract_source_attrs(entry)
      puts "ATTRS: #{attrs}"
      Source.new(attrs)
    end

  end

  def parse_entries_from(payload)
    payload.css('entry').collect do |entry|
      Rails.logger.info("$$$$ Received for #{entry.inspect} $$$$")
      entry
    end.compact
  end

  def extract_source_attrs(entry)
    data = {}
    entry.css('link[rel=enclosure][type*=audio]').collect do |attachment|
      data.merge!({
        :title => entry.css('title').first.text,
        :url => attachment.attribute('href').to_s
      })
    end
    data
  end


  def self.unsubscribe(url, id)
    service.unsubscribe(url, id) do |result|
      puts "Unsubscribed to #{url}" if result
    end
  end

  def self.service
    @client ||= ListenLater::Application::Superfeedr
  end

end
