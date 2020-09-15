def write_data_to_file(aFile)
   aFile.puts('5')
   aFile.puts('Fred')
   aFile.puts('Sam')
   aFile.puts('Jill')
   aFile.puts('Jenny')
   aFile.puts('Zorro')
end

def read_data_from_file(aFile)
  count = aFile.gets.to_i
  puts count.to_s
  puts aFile.gets
  puts aFile.gets
  puts aFile.gets
  puts aFile.gets
  puts aFile.gets
end

def main
  aFile = File.new("mydata.txt", "w") # open for writing
  if aFile  # if nil this test will be false
    write_data_to_file(aFile)
    aFile.close
  else
    puts "Unable to open file to write!"
  end

  aFile = File.new("mydata.txt", "r") # open for reading
  if aFile  # if nil this test will be false
    read_data_from_file(aFile)
    aFile.close
  else
    puts "Unable to open file to read!"
  end
end

main
