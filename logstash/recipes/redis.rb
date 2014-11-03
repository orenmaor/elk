#
# Cookbook Name:: logstash
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "logstash::install"

template "/etc/logstash/conf.d/logstash.conf" do
  source "logstash-redis.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart,"service[logstash]", :delayed
end
