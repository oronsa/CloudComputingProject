include_recipe 'apt::default'
# install mysql, using the MySQL cookbook resource
mysql_service 'default' do
  version '5.7'
  bind_address '0.0.0.0'
  port '3306'
  data_dir '/data'
  initial_root_password 'admin1'
  action [:create, :start]
end

directory "#{node[:register][:data_dir]}" do
  owner node[:register][:user]
  group node[:register][:group]
  mode 00777
  action :create
end

cookbook_file "#{node[:register][:data_dir]}loaddb.txt" do
  source 'loaddb.txt'
  owner node[:register][:user]
  group node[:register][:group]
  mode '0755'
  action :create
end

bash 'setup_mysql' do
  code <<-EOH
        sudo mysql -h 127.0.0.1 -u root -p#{node[:register][:password]} -S /var/run/mysql-default/mysqld.sock
        sudo mysql -h 127.0.0.1 -u root -p#{node[:register][:password]} < "#{node[:register][:data_dir]}loaddb.txt"
		    sudo mysql -h 127.0.0.1 -u root -p#{node[:register][:password]} -e "GRANT ALL ON *.*  TO 'root'@'%' IDENTIFIED BY '#{node[:register][:password]}';"
  EOH
end