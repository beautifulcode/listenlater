module YML
  module Config
    def self.load(file)
      puts "Loading: 'config/services/#{file}.yml'"
      config = YAML.load_file("#{Rails.root}/config/services/#{file}.yml")[Rails.env]
      config.with_indifferent_access
    end
  end
end

SUPERFEEDR_CONFIG = YML::Config.load('superfeedr')

