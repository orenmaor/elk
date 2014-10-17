#
# Cookbook Name:: kibana
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nginx"

#Generate htpasswd
require 'webrick'

passwd = WEBrick::HTTPAuth::Htpasswd.new('/dev/null')

username = node[:kibana][:username]
password = node[:kibana][:password]
passwd.set_passwd(nil, username, password)

hash = passwd.get_passwd(nil, username, false)

#Install Kibana

execute "create_kibana" do
  command "tar -C /opt/ -xzf /opt/kibana.tar.gz"
  action :nothing
end

remote_file "/opt/kibana.tar.gz" do
  source "https://download.elasticsearch.org/kibana/kibana/kibana-3.1.1.tar.gz"
  notifies :run, "execute[create_kibana]", :immediately
end

template "/etc/nginx/.htpasswd" do
  source "htpasswd.erb"
  owner "root"
  group "root"
  mode 0644
  variables ({
	:username = username,
	:password = hash
  })
  notifies :restart, "service[nginx]", :delayed
end

link "/usr/share/nginx/html/kibana" do
  to "/opt/kibana-3.1.1"
end 

template "/opt/kibana-3.1.1/config.js" do
  source "config.js.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[nginx]", :delayed
end

template "/etc/nginx/conf.d/kibana.conf" do
  source "kibana.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[nginx]", :delayed
end

template "/usr/share/nginx/html/kibana/app/dashboards/default.json" do
  source "logstash.json.erb"
  owner "root"
  group "root"
  mode 0664
end
