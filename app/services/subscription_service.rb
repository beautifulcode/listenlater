class SubscriptionService

  def self.subscribe(url, id)
    service.subscribe(url, id) do |result|
      puts "Subscribed to #{url}"  if result
    end
  end

  def self.receive(payload, id)
    Rails.logger.info("The feed #{payload} has been fetched")
    subscription = Subscription.find(id)
    payload['items'].each do |item|
      return unless item['attachments']
      item['attachments'].each do |attachment|
        if attachment['mimetype'].include? 'audio'
          Rails.logger.info("Creating source for #{item['title']}")

          subscription.sources.create({
            :title => item['title'], 
            :url => attachment['permalinkUrl']
          })
        end
      end
    end
  end

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
