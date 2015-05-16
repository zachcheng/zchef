define :download_plugin do
  plugin_path = "/home/#{params[:user]}/.vim/bundle/#{params[:bundle_name]}"

  git plugin_path do
    repository params[:repository]
    user params[:user]
    not_if { File.directory? plugin_path }
  end
end
