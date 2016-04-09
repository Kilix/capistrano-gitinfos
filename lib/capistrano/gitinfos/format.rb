require 'json'
require 'yaml'
require 'inifile'
require 'xmlsimple'

module Capistrano
    module Gitinfos
        def self.format(infos, extension = 'json', section = nil)
            case extension.downcase
                when "yml"
                    return dumpForceQuotedYaml(createInfosToDump(infos, section))

                when "xml"
                    section = section.nil? || section == '' ? 'app_version' : section

                    return XmlSimple.xml_out(createInfosToDump(infos, section), {
                        'KeepRoot' => true,
                        'XmlDeclaration' => '<?xml version="1.0"?>',
                        'NoAttr' => true
                    })

                when "ini"
                    section = section.nil? || section == '' ? 'app_version' : section

                    ini = IniFile.new
                    ini[section] = infos

                    return ini.to_s

                else
                    return JSON.pretty_generate(createInfosToDump(infos, section))+"\n"
            end
        end

        def self.createInfosToDump(infos, section = nil)
            toDump = infos
            if !section.nil? && section != ''
                sections = section.split('.')
                sections.reverse_each do |sec|
                    toDump = { sec => toDump.dup }
                end
            end

            return toDump
        end

        # Hack to force string quoting and prevent abbrev_commit to be read as float in YAML
        def self.dumpForceQuotedYaml(data)
            raw = data.dup
            pattern = "__ensure_quotes__ "
            yml = YAML.dump(ensure_quotes(raw, pattern))

            return yml.gsub(/#{Regexp.escape(pattern)}/, '')
        end

        def self.ensure_quotes(h, pattern = "__ensure_quotes__")
            h.each do |k, v|
                if v.is_a?(Hash)
                    ensure_quotes(v, pattern)
                    next
                end

                if v.is_a?(String)
                    h[k] = v + pattern
                end
            end
        end

    end
end
