service "elasticsearch" do
  action :enable
  supports :status => true, :start => true, :stop => true, :restart => true
end

directory "/data" do
  action :create
  mode 0775
  owner "elasticsearch"
  group "elasticsearch"
end

execute "elasticsarch_own" do
  command "chown elasticsearch:elasticsearch /data"
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
