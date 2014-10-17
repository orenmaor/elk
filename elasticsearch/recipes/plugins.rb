execute "install-marvel" do
  command "/usr/share/elasticsearch/bin/plugin -i elasticsearch/marvel/latest"
  not_if { ::File.directory?("#{node['elasticsearch']['maven_dir']}") }
end

execute "install-head" do
  command "/usr/share/elasticsearch/bin/plugin -i mobz/elasticsearch-head"
  not_if { ::File.directory?("#{node['elasticsearch']['head_dir']}") }
end

