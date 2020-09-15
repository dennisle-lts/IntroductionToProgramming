module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

$genre_names = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class Album
	attr_accessor :title, :artist, :genre, :tracks

	def initialize (_title, _artist, _genre, _tracks)
		@title = _title
		@artist = _artist
		@genre = _genre
		@tracks = _tracks
	end
end

class Track
	attr_accessor :name, :location

	def initialize (_name, _location)
		@name = _name
		@location = _location
	end
end


# Reads in and returns a single track from the given file
def read_track music_file
	name = music_file.gets
	location = music_file.gets
	track = Track.new(name, location)
	track
end


# Returns an array of tracks read from the given file
def read_tracks music_file
	count = music_file.gets.to_i
	tracks = Array.new
	
	i = 0
	while i < count
		track = read_track(music_file)
		tracks << track
		i = i + 1
	end
	tracks
end


# Reads in and returns a single album from the given file, with all its tracks
def read_album music_file
	album_artist = music_file.gets
	album_title = music_file.gets
	album_genre = $genre_names[music_file.gets.to_i].to_s
	tracks = read_tracks(music_file)

	album = Album.new(album_title, album_artist, album_genre, tracks)
	album
end


# Takes a single track and prints it to the terminal
def print_track track
	puts('Title: ' + track.name.to_s)
  	puts('File location: ' + track.location.to_s)
end


# Takes an array of tracks and prints them to the terminal
def print_tracks tracks
  i = 0
  for i in 0..tracks.length - 1 do
	  puts '*********************************************'
	  puts '**************** Track No. ' + (i + 1).to_s + ' ****************'
	  print_track(tracks[i])
	  puts ''
  end
end


# Takes a single album and prints it to the terminal along with all its tracks
def print_album album
	puts 'Album Title: ' + album.title
	puts 'Album Artist: ' + album.artist
	puts 'Album Genre: ' + album.genre
	puts ''
	puts 'Tracks: '
	print_tracks(album.tracks)
end


# Reads in an album from a file and then print the album to the terminal
def main
  	music_file = File.new('album.txt', 'r')
	album = read_album(music_file)
  	music_file.close()
	print_album(album)
end

main
