# version file output format and file extension
# available formats : ini, xml, yml, json
# default : json
set :gitinfos_format, "json"

# relative path from release_path without file extension
# default : version
# if :gitinfos_format = yml and :gitinfos_file = config/version
# then the final path is <release_path>/config/version.yml
set :gitinfos_file, "version"

# section name : "namespace" in the config file which will contains git commit informations
# if the namespace contains dots, it will be translated as nested path in JSON, YML and XML
set :gitinfos_section, ''
