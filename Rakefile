#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rspec/core/rake_task'
require 'faraday'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

EXAMPLES = [
  "https://www.allrecipes.com/recipe/230347/roasted-vegetable-and-couscous-salad/",
  "https://www.bbc.com/food/recipes/paella_7100",
  "https://www.bettycrocker.com/recipes/skillet-chicken-nachos/9bf0c3be-09dd-4b1b-8cf4-a9cfa979b232",
  "http://www.bigoven.com/recipe/steves-fish-tacos/178920",
  "https://www.chowhound.com/recipes/strawberry-rhubarb-pie-with-sour-cream-crust-30700",
  "https://cooking.nytimes.com/recipes/1017945-coq-au-riesling",
  "https://www.cooks.com/recipe/oc0mk7z3/lemon-bars-deluxe.html",
  "https://copykat.com/2014/12/03/low-fat-scalloped-potatoes/",
  "http://www.drinksmixer.com/drink2438.html",
  "http://www.eatingwell.com/recipe/251798/sauteed-chicken-breasts-with-creamy-chive-sauce/",
  "https://www.epicurious.com/recipes/food/views/grilled-turkey-burgers-with-cheddar-and-smoky-aioli-354289",
  "https://www.foodandwine.com/recipes/honey-glazed-roasted-root-vegetables",
  "https://www.foodnetwork.com/recipes/rachael-ray/spinach-and-mushroom-stuffed-chicken-breasts-recipe-2013365",
  "https://www.geniuskitchen.com/recipe/panda-express-orange-chicken-103215",
  "http://www.grouprecipes.com/135867/deep-dark-chocolate-cheesecake.html",
  "https://www.jamieoliver.com/recipes/pork-recipes/neck-fillet-steak/",
  "https://www.mrfood.com/Slow-Cooker-Recipes/Saucy-Italian-Pot-Roast-4268",
  "https://www.myrecipes.com/recipe/best-carrot-cake",
  "https://www.pillsbury.com/recipes/big-cheesy-pepperoni-pockets/a17766e6-30ce-4a0c-af08-72533bb9b449",
  "https://www.rachaelray.com/recipes/quick-chick-and-noodle-soup/",
  "https://www.saveur.com/article/Recipes/Smoked-Trout-Blinis-with-Creme-Fraiche-and-Dill",
  "https://www.tarladalal.com/Vegetable-Fried-Rice-(-Jain-)-8631r",
  "https://www.taste.com.au/recipes/lemon-melting-moments/e5384539-ac49-4852-939d-1c44a4917674",
  "https://www.tasteofhome.com/recipes/rhubarb-popover-pie/",
  "https://www.thespruceeats.com/white-chocolate-key-lime-muffins-recipe-1808282",
].freeze

desc 'Fetch the current versions of all the fixtures'
task :update_fixtures do
  user_agent = 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'
  dir = File.dirname(__FILE__)
  fixtures_to_remove = Dir.glob("#{dir}/spec/fixtures/*.html").map { |path| path[(dir.length + 1)..-1] }

  EXAMPLES.each do |url|
    puts "fetching \e[34;4m#{url}\e[0m...", ""

    response = Faraday.get do |request|
      request.url url
      request.headers['User-Agent'] = user_agent
    end

    case response.status
    when 301
      puts " → URL Change:",
           "   \e[31m- '#{url}',\e[0m",
           "   \e[32m+ '#{response['Location']}',\e[0m"

    when 404
      puts " → Recipe Removed:",
           "   \e[31m- '#{url}',\e[0m"

    when 200
      host = URI(url).host
      fixture = File.join("spec", "fixtures", "#{host}.html")
      fixtures_to_remove.delete fixture
      File.open(File.join(dir, fixture), 'w') { |f| f.write(response.body) }
      puts "\e[32m ✓ #{fixture} updated\e[0m"

    else
      puts "\e[31m × Unhandled response.status: \e[1m#{response.status}\e[0m"
    end

    puts ""
  end

  fixtures_to_remove.each do |path|
    puts "\e[90mrm #{path}\e[0m"
    FileUtils.rm path
  end
end
