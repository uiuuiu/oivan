require "rubygems"
require "bundler"
Bundler.require(:default)
Bundler.require(:default, settings.environment)
require 'sinatra/cache'
require 'active_support/all'

ROOT_PATH = File.dirname(File.expand_path('..', __FILE__)) 

if settings.development?
  require "sinatra/reloader"
  also_reload "#{ROOT_PATH}/helpers.rb"
  Dir["#{ROOT_PATH}/helpers/**/*.rb"].each { |file| also_reload file }
  Dir["#{ROOT_PATH}/models/**/*.rb"].each { |file| also_reload file }
  Dir["#{ROOT_PATH}/data/**/*.rb"].each { |file| also_reload file }
end

require "#{ROOT_PATH}/storage.rb"
require "#{ROOT_PATH}/models/base_model.rb"
Dir["#{ROOT_PATH}/models/**/*.rb"].each {|file| require file unless file.include?('base_model.rb') }

require "#{ROOT_PATH}/helpers.rb"
Dir["#{ROOT_PATH}/helpers/**/*.rb"].each { |file| require file }

require "#{ROOT_PATH}/data/scanners/base.rb"
Dir["#{ROOT_PATH}/data/**/*.rb"].each {|file| require file unless file.include?('base.rb') }