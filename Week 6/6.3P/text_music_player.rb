require './input_functions'

module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end


$genre_names = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class Track
	attr_accessor :name, :location

	def initialize (name, location)
		@name = name
		@location = location
	end
end

class Album
	attr_accessor :title, :artist, :genre, :tracks

	def initialize (title, artist, genre, tracks)
		@title = title
		@artist = artist
		@genre = genre
		@tracks = tracks
	end
end


# Reads in and returns a single track from the terminal
def read_track index
	track_name = read_string('Please enter track No.' + (index + 1).to_s + ' name.')
	track_file_location = read_string('Please enter track No.' + (index + 1).to_s + ' file location.')
	track = Track.new(track_name, track_file_location)
	track
end


# Reads in and returns an array of multiple tracks from the given file
def read_tracks
	tracks = Array.new()
	count = read_integer_in_range("Enter track count: ", 0, 15)
	i = 0
	while i < count
		track = read_track(i)
		tracks << track
		i += 1
	end
	tracks
end


# Display the genre names in a
# numbered list and ask the user to select one
def read_genre()
	count = $genre_names.length
	i = 0
	puts 'Genre: '
	while i < count
		puts "#{i} " + $genre_names[i]
		i += 1
	end
	selectedGenre = read_integer_in_range('Please select your album genre.', 0, count - 1)
	selectedGenre
end


# Reads in and returns a single album from the terminal, with all its tracks
def read_album
  album_title = read_string("Please enter album title.")
	album_artist = read_string("Please enter album artist.")
  album_genre = $genre_names[read_genre].to_s
  tracks = read_tracks
	album = Album.new(album_title, album_artist, album_genre, tracks)
	album
end


# Takes an array of tracks and prints them to the terminal
def print_tracks tracks
	puts 'Tracks: '
	for i in 0...tracks.length do
		track = tracks[i]
	  puts '*********************************************'
	  puts '**************** Track No. ' + (i + 1).to_s + ' ****************'
		puts 'Track name: ' + track.name
		puts 'Track file location: ' + track.location
		i += 1
	end
end


# Takes a single album and prints it to the terminal
def print_album album
	puts '*********************************************'
	puts 'Album Title: ' + album.title
	puts 'Album Artist: ' + album.artist
	puts 'Genre: ' + album.genre
	puts ''
	print_tracks(album.tracks)
end


# Reads in an array of albums from a file and then prints all the albums in the
# array to the terminal
def main
  puts "Welcome to the music player"
	album = read_album()
	print_album(album)
end

main
