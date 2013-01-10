require 'pathname'
files = Dir.glob("./*").map { |f| Pathname.new(f) }

files.each do |file|
  puts "FILE: #{file.realpath.to_s}"
  unless file.basename.to_s == "install.rb"
    `rm ~/.#{file.basename.to_s} -f`
    `ln -s #{file.realpath.to_s} ~/.#{file.basename.to_s}`
  end
end

files.each do |file|
  `source ~/.#{file.basename.to_s}`
end
