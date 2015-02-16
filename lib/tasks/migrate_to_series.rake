desc "Move from subscription model to series model"
task :migrate_to_series => :environment do
  user = User.find(1)
  subs = read_csv('subscriptions')
  subs.each do |sub|
    series = Series.find_by_url(sub[:url])
    series ||= Series.create(title: sub[:title], url: sub[:url], image_url: sub[:image_url])
    user.subscribed_series << series
    user.save
    puts "Subscribed: #{series[:title]}"
  end
end

def read_csv(name)
  SmarterCSV.process("#{Rails.root}/db/#{name}.csv")
end
