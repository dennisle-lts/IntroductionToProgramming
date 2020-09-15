def write(file, number)
  aFile = File.new(file, "w")
  if aFile 
    aFile.puts(number)
    index = 0
    while (index < number)
     aFile.puts(index.to_s)
     index += 1
    end
  else 
    puts "Unable to open file to write!"
  end
  aFile.close
end

# Read the data from the file and print out each line
def read(file)
  aFile = File.new(file)
  if aFile
    count = aFile.gets.chomp
    if (is_numeric?(count))
      count = count.to_i
    else
      count = 0
      puts "Error: first line of file is not a number"
    end
  
    index = 0
    while (count > index)
      line = aFile.gets
      puts "Line read: " + line
      index += 1
    end
  end
  aFile.close
end

# Write data to a file then read it in and print it out
def main
  write("mydata.txt", 10)
  read("mydata.txt")
end

# returns true if a string contains only digits
def is_numeric?(obj)
  if /[^0-9]/.match(obj) == nil
    true
  else 
    false
  end
end

main
