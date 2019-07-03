def read_laws(conf_file_name)
  conf_file = File.readlines(conf_file_name).map { |line| line.split(/\w+/) }


end
