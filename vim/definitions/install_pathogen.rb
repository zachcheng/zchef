define :install_pathogen do
  user = params[:user]

  %w[.vim .vim/swp .vim/swp/backup .vim/swp/tmp .vim/autoload .vim/bundle].each do |path|
    directory "/home/#{user}/#{path}" do
      owner user
      group 'opsworks'
    end
  end

  remote_file "/home/#{user}/.vim/autoload/pathogen.vim" do
    source "https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim"
    action :create_if_missing
    owner user
    group 'opsworks'
  end
end
