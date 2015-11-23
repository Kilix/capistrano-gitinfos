def getGitInfos(commit)
    rawCommitDate = capture(:git, "log -1 --pretty=tformat:'{%ci}' --no-color --date=local #{commit}").slice(/\{(.+)\}/,1)
    abbrevCommit = capture(:git, "rev-list --max-count=1 --abbrev-commit #{commit}")
    fullCommit = capture(:git, "rev-list --max-count=1 --no-abbrev-commit #{commit}")
    version = capture(:git, "describe --tag #{commit}")

    deployDate = DateTime.strptime(release_timestamp, "%Y%m%d%H%M%S")
    commitDate = DateTime.strptime(rawCommitDate, "%Y-%m-%d %H:%M:%S %z")

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

def formatGitInfos(infos, format)
    case format
        when "yml"
            return YAML.dump(infos)

        when "xml"
            builder = Nokogiri::XML::Builder.new do |xml|

                xml.send("#{fetch(:gitinfos_section)}") do
                    infos.each do |key, value|
                        xml.send(key, value)
                    end
                end
            end

            return builder.to_xml

        when "ini"
            ini = IniFile.new
            ini["#{fetch(:gitinfos_section)}"] = infos

            return ini.to_s

        else
            set :gitinfos_format, "json"
            return JSON.pretty_generate(infos)+"\n"
    end
end

namespace :gitinfos do
    task :set_version_infos do
        on release_roles :all do
            within repo_path do
                with fetch(:git_environmental_variables) do
                    infos = formatGitInfos(getGitInfos(fetch(:branch)), fetch(:gitinfos_format))
                    upload! StringIO.new(infos),  "#{release_path}/#{fetch(:gitinfos_file)}.#{fetch(:gitinfos_format)}"
                end
            end
        end
    end
end
