class SubscriptionService

  def self.subscribe(url)
    service.subscribe(url) do |result|
      puts "Subscribed to #{url}"  if result
    end
  end

  def self.receive(notification)
    #service.on_notification do |notification|
      #puts "The feed #{notification.feed_url} has been fetched (#{notification.http_status}: #{notification.message_status}) and will be fecthed again in #{(notification.next_fetch - Time.now)/60} minutes."
      #notification.entries.each do |e|
        #puts " - #{e.title} (#{e.link}) was published (#{e.published}) with #{e.unique_id} as unique id : \n #{e.summary} (#{e.chunk}/#{e.chunks})"
      #end
    #end
  end

  def self.unsubscribe(url)
    service.unsubscribe(url) do |result|
      puts "Unsubscribed to #{url}" if result
    end
  end

  def self.service
    #@client ||= Superfeedr
    @client ||= ListenLater::Application::Superfeedr
  end

end
