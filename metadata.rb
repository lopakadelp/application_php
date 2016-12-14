name             "application_php"
maintainer       "ZephirWorks"
maintainer_email "andrea.campi@zephirworks.com"
license          "Apache 2.0"
description      "Deploys and configures PHP-based applications"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "2.0.2"

chef_version '>= 12.0' if respond_to?(:chef_version)
depends "application", "~> 4.1"
depends "apache2"
depends "php"
