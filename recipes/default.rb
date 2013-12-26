case node['platform']
when "ubuntu", "debian"
  node['unimrcp']['packages'].each do |pkg|
    package pkg do
      options "--force-yes"
    end
  end
end

unimrcp_name = "uni-ast-package-#{node['unimrcp']['version']}"
work_dir = Chef::Config['file_cache_path'] || '/tmp'
unimrcp_src_dir = "#{work_dir}/#{unimrcp_name}"

target_dir = node['unimrcp']['install_dir']

apr_src_dir = "#{unimrcp_src_dir}/unimrcp/libs/apr"

check_installed = 'test -f /usr/local/unimrcp/lib/libunimrcpclient.a'

remote_file "#{work_dir}/#{unimrcp_name}.tar.gz" do
  source "http://unimrcp.googlecode.com/files/#{unimrcp_name}.tar.gz"
  not_if check_installed
end

bash "prepare_dir" do
  user "root"
  cwd work_dir
  code "tar -zxf #{unimrcp_name}.tar.gz"
  not_if check_installed
end

bash "install_apr" do
  user "root"
  cwd apr_src_dir
  code <<-EOH
    ./configure --prefix=#{target_dir}
    make
    make install
  EOH
  not_if 'test -f /usr/local/unimrcp/lib/libapr-1.a'
end

bash "install_apr_util" do
  user "root"
  cwd "#{unimrcp_src_dir}/unimrcp/libs/apr-util"
  code <<-EOH
    ./configure --prefix=#{target_dir} --with-apr=#{apr_src_dir}
    make
    make install
  EOH
  not_if 'test -f /usr/local/unimrcp/lib/libaprutil-1.a'
end

bash "install_sofia" do
  user "root"
  cwd "#{unimrcp_src_dir}/unimrcp/libs/sofia-sip"
  code <<-EOH
    ./configure --with-glib=no
    make
    make install
  EOH
  not_if 'test -f /usr/local/lib/libsofia-sip-ua.a'
end

bash "install_unimrcp" do
  user "root"
  cwd "#{unimrcp_src_dir}/unimrcp"
  code <<-EOH
    ./configure --prefix=#{target_dir} --with-apr=#{target_dir} --with-apr-util=#{target_dir}
    make
    make install
  EOH
  not_if check_installed
end

bash "ldconfig" do
  user "root"
  cwd unimrcp_src_dir
  code 'ldconfig'
  not_if check_module
end
