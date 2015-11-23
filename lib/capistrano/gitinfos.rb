require 'json'
require 'yaml'
require 'inifile'
require 'nokogiri'
require "capistrano/gitinfos/version"
require "capistrano/gitinfos/gitinfos"

load File.expand_path("../tasks/deploy.rake", __FILE__)

namespace :load do
  task :defaults do
    load "capistrano/gitinfos/defaults.rb"
  end
end
