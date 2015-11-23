namespace :deploy do
  task :set_current_revision do
    invoke "gitinfos:set_version_infos"
  end
end
