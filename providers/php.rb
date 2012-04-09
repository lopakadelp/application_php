#
# Cookbook Name:: application_php
# Provider:: php
#
# Copyright 2012, ZephirWorks
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include Chef::Mixin::LanguageIncludeRecipe

action :before_compile do

  include_recipe 'php'

  new_resource.local_settings_file 'LocalSettings.php' unless new_resource.local_settings_file

  new_resource.symlink_before_migrate.update({
    new_resource.local_settings_file_name => new_resource.local_settings_file
  })

end

action :before_deploy do

  new_resource.packages.each do |name,ver|
    php_pear name do
      action :install
      version ver if ver && ver.length > 0
    end
  end

  if new_resource.database_master_role
    dbm = new_resource.find_matching_role(new_resource.database_master_role)

    # Assuming we have one...
    if dbm
      template "#{new_resource.path}/shared/#{new_resource.local_settings_file_name}" do
        source new_resource.settings_template || "#{new_resource.local_settings_file_name}.erb"
        owner new_resource.owner
        group new_resource.group
        mode "644"
        variables(
          :path => "#{new_resource.path}/current",
          :host => (dbm.attribute?('cloud') ? dbm['cloud']['local_ipv4'] : dbm['ipaddress']),
          :database => new_resource.database
        )
      end
    else
      Chef::Log.warn("No node with role #{new_resource.database_master_role}")
    end
  end

end

action :before_migrate do
end

action :before_symlink do
end

action :before_restart do
end

action :after_restart do
end
