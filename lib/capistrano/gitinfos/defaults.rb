# version file output format and file extension
# available formats : ini, xml, yml, json
# default : json
set :gitinfos_format, "json"

# relative path from release_path without file extension
# default : version
# if :gitinfos_format = yml and :gitinfos_file = config/version
# then the final path is <release_path>/config/version.yml
set :gitinfos_file, "version"

# XML root tag or INI section (only for XML or INI format)
set :gitinfos_section, "app_version"
