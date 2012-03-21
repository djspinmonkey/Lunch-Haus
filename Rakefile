# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

LunchHaus::Application.load_tasks

namespace :routes do
  task :check => :environment do
    Rails.application.reload_routes!
    all_routes = Rails.application.routes.routes

    if ENV['CONTROLLER']
      all_routes = all_routes.select{ |route| route.defaults[:controller] == ENV['CONTROLLER'] }
    end

    routes = all_routes.collect do |route|

      reqs = route.requirements.dup
      reqs[:to] = route.app unless route.app.class.name.to_s =~ /^ActionDispatch::Routing/
      reqs = reqs.empty? ? "" : reqs.inspect

      {:name => route.name.to_s, :verb => route.verb.to_s, :path => route.path, :reqs => reqs}
    end

     # Skip the route if it's internal info route
    routes.reject! { |r| r[:path] =~ %r{/rails/info/properties|^/assets} }

    name_width = routes.map{ |r| r[:name].length }.max
    verb_width = routes.map{ |r| r[:verb].length }.max
    path_width = routes.map{ |r| r[:path].length }.max

    seen_routes = Set.new

    routes.each do |r|
      route_string = "#{r[:name].rjust(name_width)} #{r[:verb].ljust(verb_width)} #{r[:path].ljust(path_width)} #{r[:reqs]}"
      if seen_routes.include? r.slice(:verb, :path)
        route_string = route_string.hl(:red)
      else
        seen_routes << r.slice(:verb, :path)
      end
      puts route_string
    end
  end
end