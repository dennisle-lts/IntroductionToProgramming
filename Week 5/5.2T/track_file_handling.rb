class Track
  attr_accessor :title, :file_location
  def initialize(_title, _file_location)
    @title = _title
    @file_location = _file_location
  end
end

# Returns an array of tracks read from the given file
def read_tracks music_file
	count = music_file.gets().to_i
  tracks = Array.new

  i = 0
  while i < count
    track = read_track(music_file)
    tracks << track
    i = i + 1
  end
	tracks
end

# reads in a single track from the given file.
def read_track(a_file)
  title = a_file.gets()
  file_location = a_file.gets()
  track = Track.new(title, file_location)
  track
end


# Takes an array of tracks and prints them to the terminal
def print_tracks tracks
  count = tracks.length
  i = 0
  while i < count do
    print_track(tracks[i])
    i = i + 1
  end
end

# Takes a single track and prints it to the terminal
def print_track track
  puts '************************************************'
  puts('Track title is: ' + track.title)
	puts('Track file location is: ' + track.file_location)
end

# Open the file and read in the tracks then print them
def main
  a_file = File.new("input.txt", "r") # open for reading
  if a_file  # if nil this test will be false
    tracks = read_tracks(a_file)
    a_file.close
  else
    puts "Unable to open file to read!"
  end
  # Print all the tracks
  print_tracks(tracks)
end

main
