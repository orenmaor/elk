devices = Dir.glob('/dev/xvd?')
devices -= ['/dev/xvda']

unless devices.empty?
  device = devices.sort.last

  directory "/data" do
    action :create
    mode 0775
    owner "elasticsearch"
    group "elasticsearch"
  end

  execute 'mkfs' do
    command "mkfs.ext4 #{device}"
    not_if "grep -qs /data /proc/mounts"
  end

  mount "/data" do
    device "#{device}" 
    fstype 'ext4'
    options "rw"
    action [:enable, :mount]
  end
end

execute "elasticsarch_own" do
  command "chown elasticsearch:elasticsearch /data"
end
