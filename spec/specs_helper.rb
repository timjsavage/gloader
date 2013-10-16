# Encoding: utf-8

def remove_config_files
  [:default, :state].each do |type|
    if File.exists?(GLoader::Config.new.config_path(type))
      File.delete GLoader::Config.new.config_path(type)
    end
  end
end
