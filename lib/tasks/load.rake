namespace :ctracker do
  desc "Load countries and currencies"
  task :load => :environment do
    puts "-- Loading Currencies and Countries"
    DataUpdater.instance.update
  end
end

namespace :db do
  task :seed => ["ctracker:load"]
end
