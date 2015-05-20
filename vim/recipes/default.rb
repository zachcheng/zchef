vim_user = node[:vim][:user] || node[:developers][node[:opsworks][:instance][:hostname]]
Chef::Log.info "VIM User: #{vim_user}"

if vim_user

  package 'vim-enhanced' do
    options "./configure --with-features=huge --enable-rubyinterp \ --enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7-config \ --enable-gui=gtk2 --enable-cscope --prefix=/usr"
    action :upgrade
  end

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

  execute 'root setup vimrc: symlink .vimrc in /root to vim_user .vimrc file' do
    command "ln -s /home/#{vim_user}/.vimrc /root/.vimrc"
  end

end
