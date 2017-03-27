#This program is supposed to slice off the first len characters of all filenames in a directory, provided that they have the prefix prefix
#This code isn't working yet, but should be made to function properly after a few edits are made.
require 'strscan'
prefix = "aln";
len = 2;
Dir.chdir("/home/kruegerdata/dumb")                 #Look at this directory.
filenames = Dir.glob("*.bam")                         #Get all file with this extension.
#print(filenames.size)                                 #print the number of filenames that are being worked with.
filenames.each do |filename|                          #work with each filename
scanner = StringScanner.new(filename)
  filename=filename.slice! "aln";
  print(filename)
  #File.rename(filename, tfName)#
 end

