NUM_ITEMS = 500

MAX_VALUE = 100
num_compare = 0
arr = Array.new(NUM_ITEMS)


for i in (0..NUM_ITEMS - 1)
  arr[i] = rand(MAX_VALUE + 1)
end

puts "Input array:"
for i in (0..NUM_ITEMS - 1)
  puts "arr[" + i.to_s + "] ==> " + arr[i].to_s
end

for i in (0..NUM_ITEMS - 1)
   j = i
   done = false
   while ((j > 0) and (! done))
     num_compare = num_compare + 1
     if (arr[j] < arr[j - 1])
       temp = arr[j - 1]
       arr[j - 1] = arr[j]
       arr[j] = temp
     else
       done = true
     end
     j = j - 1
   end
 end

puts "Sorted array:"
for i in (0..NUM_ITEMS - 1)
  puts "arr[" + i.to_s + "] ==> " + arr[i].to_s
end
puts "Number of Comparisons ==> " + num_compare.to_s
