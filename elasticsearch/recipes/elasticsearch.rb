service "elasticsearch" do
  action :enable
  supports :status => true, :start => true, :stop => true, :restart => true
end

include_recipe "elasticsearch::plugins"
include_recipe "elasticsearch::ec2"

template "/etc/elasticsearch/elasticsearch.yml" do
  source "etc/elasticsearch/elasticsearch.yml.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[elasticsearch]", :delayed
end
