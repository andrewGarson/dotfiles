require 'pathname'
files = Dir.glob("./*").map { |f| Pathname.new(f) }

files.each do |file|
  unless file.basename.to_s == "install.rb"
    dotfile = file.realpath.to_s
    target = File.expand_path(".#{file.basename.to_s}", "~")

    puts "rm #{target}"
    `rm #{target} -f`
    puts "link #{target} -> #{dotfile}"
    `ln -s #{dotfile} #{target}`
  end
end

files.each do |file|
  `source ~/.#{file.basename.to_s}`
end
