name             'application_php'
maintainer       'ZephirWorks'
maintainer_email 'andrea.campi@zephirworks.com'
license          'Apache 2.0'
description      'Deploys and configures PHP-based applications'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '3.0.0'
issues_url 'https://github.com/poise/application_php'
source_url       'https://github.com/poise/application_php'

chef_version '>= 12.7' if respond_to?(:chef_version)
depends 'application'
depends 'apache2'
depends 'php'
