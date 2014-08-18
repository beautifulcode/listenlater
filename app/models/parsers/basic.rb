module Parsers
  class Basic

    def initialize(xml)
      @xml = xml
      @duration = parse_duration
      @notes = parse_notes
      @author = parse_author
      @summary = parse_subtitle_or_summary
      @tags = parse_tags
    end

    def parse_duration
      text_from_node("itunes:duration")
    end

    def parse_notes
      text_from_node("content:encoded")
    end

    def parse_author
      text_from_node("itunes:author")
    end

    def parse_subtitle_or_summary
      sub = text_from_node("itunes:subtitle")
      sum = text_from_node("itunes:summary")
      text = sub unless sub.blank?
      text ||= sum unless sub
    end

    def parse_tags
      text_from_node("itunes:keywords")
    end

    def text_from_node(selector)
      node = Nokogiri::XML(@xml).css(selector)
      node.text
    end

  end
end
