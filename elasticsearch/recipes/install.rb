remote_file "#{Chef::Config[:file_cache_path]}/elasticsearch.rpm" do
    source "#{node['elasticsearch']['rpm_url']}"
    action :create
end

rpm_package "elasticsearch-rpm" do
    source "#{Chef::Config[:file_cache_path]}/elasticsearch.rpm"
    action :install
end
