include_recipe 'apt'

package 'ruby-sinatra'
package 'mysql-server'
package 'ruby-mysql2'

remote_directory "#{node[:register][:app_dir]}" do
  mode 00777
  owner node[:register][:user]
  group node[:register][:group]
  action :create
end

template "#{node[:register][:app_dir]}condb.rb" do
  source 'condb.erb'
  variables ({mysqlip: node[:register][:db_ip],
              dbpass: node[:register][:password]})
end

execute "run-app" do
  cwd '/home/ubuntu/register'
	command 'ruby index.rb'
end