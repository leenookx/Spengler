require 'yaml'

EMAIL_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/email.yml")
