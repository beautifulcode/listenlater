class Series < ActiveRecord::Base
  attr_accessible :title, :url, :image_url, :description
  has_many :subscriptions
  has_many :sources, through: :subscriptions

  acts_as_taggable

  after_create :subscribe
  after_create :parse_meta
  after_destroy :unsubscribe


  scope :ordered, :order => "title ASC"

  def image_url
    attributes[:image_url].blank? ? default_image_url : attributes[:image_url]
  end

  def default_image_url
    'series/default.gif'
  end

  def parse_meta
    parse_artwork
    parse_description
  end

  def parse_description
    begin
      raw_xml = HTTParty.get(self.url).body
      xml_doc = Nokogiri::XML(raw_xml)
      descrip = xml_doc.css("channel > description").text
      descrip = xml_doc.css("itunes|summary").first['href'] if descrip.blank?
      self.update_attribute('description', descrip)
      descrip
    rescue
      puts "Couldn't parse description from #{self.url}"

    end
  end

  def parse_artwork
    begin
      raw_xml = HTTParty.get(self.url).body
      xml_doc = Nokogiri::XML(raw_xml)
      img_url = xml_doc.css("channel > image > url").text
      img_url = xml_doc.css("itunes|image").first['href'] if img_url.blank?
      puts img_url
      self.update_attribute(:image_url, img_url)
      img_url
    rescue
      puts "Couldn't parse image from #{self.url}"

    end
  end


  protected

    def subscribe
     SubscriptionService.subscribe(url, id)
    end

    def unsubscribe
     SubscriptionService.unsubscribe(url, id)
    end


end
