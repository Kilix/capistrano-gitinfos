def getGitInfos(commit)
    rawCommitDate = capture(:git, "log -1 --pretty=tformat:'{%ci}' --no-color --date=local #{commit}").slice(/\{(.+)\}/,1).sub(/\s/, 'T').sub(/\s/, '')
    abbrevCommit = capture(:git, "rev-list --max-count=1 --abbrev-commit #{commit}")
    fullCommit = capture(:git, "rev-list --max-count=1 --no-abbrev-commit #{commit}")
    version = capture(:git, "describe --tag --always #{commit}")
    if version.empty?
        version = abbrevCommit
    end

    deployDate = Time.strptime(release_timestamp+'UTC', "%Y%m%d%H%M%S%z").utc
    commitDate = Time.strptime(rawCommitDate, "%Y-%m-%dT%H:%M:%S%z").utc

    return {
        'version' => version,
        'abbrev_commit' => abbrevCommit,
        'full_commit' => fullCommit,
        'commit_date' => commitDate.strftime('%FT%T%z'),
        'commit_timestamp' => commitDate.strftime('%s'),
        'deploy_date' => deployDate.strftime('%FT%T%z'),
        'deploy_timestamp' => deployDate.strftime('%s'),
    }
end

namespace :gitinfos do
    task :set_version_infos do
        on release_roles :all do
            within repo_path do
                with fetch(:git_environmental_variables) do

                    extension = fetch(:gitinfos_format)
                    if !['yml','ini','xml','json'].include?(extension)
                        set :gitinfos_format, 'json'
                        extension = 'json'
                    end

                    infos = Capistrano::Gitinfos.format(getGitInfos(fetch(:branch)), extension, fetch(:gitinfos_section))
                    upload! StringIO.new(infos),  "#{release_path}/#{fetch(:gitinfos_file)}.#{extension}"
                end
            end
        end
    end
end
