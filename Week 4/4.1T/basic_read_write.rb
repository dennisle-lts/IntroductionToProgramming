
# writes the number of lines then each line as a string.

def write_data_to_file(a_file)
   a_file.puts('5')
   a_file.puts('Fred')
   a_file.puts('Sam')
   a_file.puts('Jill')
   a_file.puts('Jenny')
   a_file.puts('Zorro')
end

def read_data_from_file(a_file)
  count = a_file.gets.to_i
  puts count.to_s
  puts a_file.gets
  puts a_file.gets
  puts a_file.gets
  puts a_file.gets
  puts a_file.gets
end

def main
  a_file = File.new("mydata.txt", "w") # open for writing
  if a_file  # if nil this test will be false
    write_data_to_file(a_file)
    a_file.close
  else
    puts "Unable to open file to write!"
  end

  a_file = File.new("mydata.txt", "r") # open for reading
  if a_file  # if nil this test will be false
    read_data_from_file(a_file)
    a_file.close
  else
    puts "Unable to open file to read!"
  end
end

main
