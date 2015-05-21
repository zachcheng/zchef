developer = node[:developers][node[:opsworks][:instance][:hostname]] || 'zdefault'

execute "set up rvm for developer" do
  command "gpasswd -a #{developer} rvm"
end 

