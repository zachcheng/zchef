developer = node[:developers][node[:opsworks][:instance][:hostname]] || 'zdefault'
Chef::Log.info "Git Developer: #{developer}"

if developer

  name = developer
  email = node[:git][developer]
  Chef::Log.info "Git Developer Email: #{email}"

  template "/home/#{developer}/.gitconfig" do
    source "gitconfig.erb"
    owner developer
    group 'opsworks'
    variables :email => email, :name  => name
    action :create_if_missing
  end

end
