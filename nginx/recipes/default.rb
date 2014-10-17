#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "nginx" do 
  action :install
end

service "nginx" do
  action :enable
  supports :status => true, :start => true, :stop => true, :restart => true
end
