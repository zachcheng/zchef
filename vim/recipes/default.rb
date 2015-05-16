vim_user = node[:vim][:user] || node[:developers][node[:opsworks][:instance][:hostname]]
Chef::Log.info "VIM User: #{vim_user}"

if vim_user
  load_recipe 'vim::vim74'

  install_pathogen do
    user vim_user
  end

  node[:vim][:plugins].each do |bundle, repo|
    download_plugin do
      user vim_user
      repository repo
      bundle_name bundle
    end
  end

  command_t do
    user vim_user
  end

  template "/home/#{vim_user}/.vimrc" do
    source "vimrc.erb"
    owner vim_user
    group 'opsworks'
    action :create_if_missing
  end
end
