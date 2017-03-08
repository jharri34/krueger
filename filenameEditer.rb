#This program is supposed to slice off the first len characters of all filenames in a directory, provided that they have the prefix prefix
#This code isn't working yet, but should be made to function properly after a few edits are made.
require 'strscan'
prefix = "a";
len = 1;
i = 0;
Dir.chdir("/home/UAB/jpd1995/dummy/")                 #Look at this directory.
filenames = Dir.glob("*.txt")                         #Get all file with this extension.
print(filenames.size)                                 #print the number of filenames that are being worked with.
filenames.each do |filename|                          #work with each filename
scanner = StringScanner.new(filename)
  s=scanner.peek len                                    #String =first len characters.
  tfName=filename;
  if(s==prefix)
    print(tfName)
    tfName[len..-1]               
    print(tfName)
  print("\n")
  end
  File.absolute_path("/home/UAB/jpd1995/dummy/")
  File.rename(filename, tfName)#
  i += 1
 end

#readlink -f fileNameEditor.rb
