require "hanoi_helpers"
require "recursive_hanoi"
require "iterative_hanoi"
require 'optparse'

options = {}
optparse = OptionParser.new do |opts|
  opts.banner = "Usage: ruby main.rb [options]"

  opts.on("-i", "--iterative", "Run iterative hanoi") do |option|
    options[:type] = "IterativeHanoi"
  end

  opts.on("-r", "--recursive", "Run recursive hanoi") do |option|
    options[:type] = "RecursiveHanoi"
  end

  opts.on("-d", "--disks NUM", "Number of disks to use") do |option|
    options[:disks] = option.to_i
  end
end

begin
  optparse.parse!
  mandatory = [:type, :disks]
  missing = mandatory.select{ |param| options[param].nil? }
  if not missing.empty?
    puts "Missing options: #{missing.join(', ')}"
    puts optparse
    exit
  end
rescue OptionParser::InvalidOption, OptionParser::MissingArgument
  puts $!.to_s
  puts optparse
  exit
end

Kernel.const_get(options[:type]).new(:discs => options[:disks]).solve