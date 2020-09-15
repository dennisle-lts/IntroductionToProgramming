NUM_ITEMS = 35
MAX_VALUE = 100

num_compare = 0
arr = Array.new(NUM_ITEMS)

for i in (0..NUM_ITEMS - 1)
    arr[i] = rand(MAX_VALUE + 1)
end

puts "Input list:"
for i in (0..NUM_ITEMS - 1)
  puts "arr[" + i.to_s + "] ==> " + arr[i].to_s
end

for i in (0..NUM_ITEMS - 2)
  min_pos = i
  for j in (i + 1)..(NUM_ITEMS - 1)
    num_compare = num_compare + 1
    if (arr[j] < arr[min_pos])
      min_pos = j
    end
  end

  temp = arr[i]
  arr[i] = arr[min_pos]
  arr[min_pos] = temp
end


puts "Sorted list:"
for i in (0..NUM_ITEMS - 1)
  puts "arr[" + i.to_s + "] ==> " + arr[i].to_s
end

puts "Number of Comparisons ==> " + num_compare.to_s
