define :command_t do
  vim_user = params[:user]

  unless File.directory? "/home/#{vim_user}/bundle/command-t"
    download_plugin do
      user vim_user
      repository 'https://github.com/wincent/Command-T.git'
      bundle_name 'command-t'
    end

    execute 'ruby extconf.rb' do
      command 'ruby extconf.rb'
      cwd "/home/#{vim_user}/.vim/bundle/command-t/ruby/command-t"
    end

    execute 'make' do
      command 'make'
      cwd "/home/#{vim_user}/.vim/bundle/command-t/ruby/command-t"
    end
  end
end
