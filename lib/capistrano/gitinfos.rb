require 'active_support/time'
require "capistrano/gitinfos/version"
require "capistrano/gitinfos/gitinfos"
require "capistrano/gitinfos/format"

load File.expand_path("../tasks/deploy.rake", __FILE__)

namespace :load do
  task :defaults do
    load "capistrano/gitinfos/defaults.rb"
  end
end
