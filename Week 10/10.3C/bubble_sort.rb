
NUM_ITEM = 35
MAX_VALUE = 100
num_compare = 0
arr = Array.new(NUM_ITEM)


for i in (0..NUM_ITEM - 1)
  arr[i] = rand(MAX_VALUE + 1)
end

puts "Input array:"
for i in (0..NUM_ITEM - 1)
  puts "arr[" + i.to_s + "] ==> " + arr[i].to_s
end

for i in (0..NUM_ITEM - 2)
  for j in ((i + 1)..NUM_ITEM - 1)
    num_compare = num_compare + 1
    if (arr[i] > arr[j])
      temp = arr[j]
      arr[j] = arr[i]
      arr[i] = temp
    end
  end
end


puts "Sorted array:"
for i in (0..NUM_ITEM - 1)
  puts "arr[" + i.to_s + "] ==> " + arr[i].to_s
end
puts "Number of Comparisons ==> " + num_compare.to_s
