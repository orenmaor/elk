execute "install-aws-cloud" do
  command "/usr/share/elasticsearch/bin/plugin -i elasticsearch/elasticsearch-cloud-aws/2.3.0"
  not_if { ::File.directory?("#{node['elasticsearch']['aws_dir']}") }
end

