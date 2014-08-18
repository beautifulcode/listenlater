class SubscriptionService

  def self.subscribe(url, id)
    service.subscribe(url, id) do |result|
      puts "Subscribed to #{url}"  if result
    end
  end

  # XML
  def receive(payload, id)
    Rails.logger.info("The feed #{payload} has been fetched")
    series = Series.find(id)

    # Legacy data in superfeedr that points to sub vs seris
    series ||= Subscription.find(id).series

    series.sources << parse_sources(payload)
    series.save

  end

  def parse_sources(payload)
    #Parsers::Basic.new(payload)

    parse_entries_from(payload).collect do |entry|
      Source.new(extract_source_attrs(entry))
    end

  end

  def parse_entries_from(payload)
    payload.css('entry').collect do |entry|
      Rails.logger.info("$$$$ Received for #{entry.inspect} $$$$")
      entry unless entry.css('link[rel=enclosure]')
    end
  end

  def extract_source_attrs(entry)
    data = {}
    entry.css('link[rel=enclosure][type~=audio]').each do |attachment|
      data.merge({
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
