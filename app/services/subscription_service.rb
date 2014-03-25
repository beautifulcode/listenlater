class SubscriptionService

  def self.subscribe(url, id)
    service.subscribe(url, id) do |result|
      puts "Subscribed to #{url}"  if result
    end
  end

  # XML
  def self.receive(payload, id)
    Rails.logger.info("The feed #{payload} has been fetched")
    subscription = Subscription.find(id)
    payload.css('entry').each do |entry|
      Rails.logger.info("$$$$ Received for #{entry.inspect} $$$$")
      return unless entry.css('link[rel=enclosure]')
      entry.css('link[rel=enclosure]').each do |attachment|
        if attachment.attribute('type').to_s.include? 'audio'
          Rails.logger.info("Creating source for #{entry.css('title')}")

          source = subscription.sources.new({
            :user_id => subscription.user_id,
            :title => entry.css('title').first.text,
            :url => attachment.attribute('href').to_s
          })

          source.user = subscription.user
          source.save
        end
      end
    end
  end

  # JSON
  #def self.receive(payload, id)
  #  Rails.logger.info("The feed #{payload} has been fetched")
  #  subscription = Subscription.find(id)
  #  payload['items'].each do |item|
  #    return unless item['attachments']
  #    item['attachments'].each do |attachment|
  #      if attachment['mimetype'].include? 'audio'
  #        Rails.logger.info("Creating source for #{item['title']}")

  #        subscription.sources.create({
  #          :title => item['title'],
  #          :url => attachment['permalinkUrl']
  #        })
  #      end
  #    end
  #  end
  #end


  def self.unsubscribe(url, id)
    service.unsubscribe(url, id) do |result|
      puts "Unsubscribed to #{url}" if result
    end
  end

  def self.service
    #@client ||= Superfeedr
    @client ||= ListenLater::Application::Superfeedr
  end

end
