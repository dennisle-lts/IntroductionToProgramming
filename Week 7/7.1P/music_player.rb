require './input_functions'
require 'colorize' # gem install colorize
require 'spreadsheet' # gem install spreadsheet



class Track
	attr_accessor :id, :title, :location

	def initialize (id, title, location)
		@id = id
		@title = title
		@location = location
	end
end

class Album
	attr_accessor :id, :title, :artist, :genre, :tracks, :updated

	def initialize (id, title, artist, genre, tracks)
		@id = id
		@title = title
		@artist = artist
		@genre = genre
		@tracks = tracks
		@updated = false
	end
end

# =============================================================
# Menu
# =============================================================
# Main menu
def main_menu
	finished = false
	begin
	  puts ' Text Music Player             '.colorize(:color => :black, :background => :yellow)
	  puts
	  puts ' Main Menu:                    '.colorize(:color => :while, :background => :blue)
	  puts '1 - Read in Album              '.colorize(:color => :black, :background => :white)
	  puts '2 - Display Albums Info        '.colorize(:color => :black, :background => :white)
	  puts '3 - Play Album                 '.colorize(:color => :black, :background => :white)
	  puts '4 - Update Album               '.colorize(:color => :black, :background => :white)
	  puts '5 - Exit                       '.colorize(:color => :black, :background => :white)
	  choice = read_integer_in_range("Option: ", 1, 5)
	  case choice
	  when 1
		database_file = read_file
		albums = read_albums(database_file)
	  when 2
		if validate(albums)
			print_albums_info(albums)
		end
	  when 3
		if validate(albums)
			play_album(albums)
		end
	  when 4
		if validate(albums)
			select_update_album(albums)
		end
	  else
		if isUpdated(albums)
			puts 'Updating album file infomation..'
		end
		finished = true
	  end
	end until finished
end

# Read File
def read_file
	system "clear" or system "cls"
	finished = false
	begin
		puts "   Enter Album                             ".colorize(:color => :white, :background => :blue)
		puts "   Enter the filename of the music library ".colorize(:color => :black, :background => :white)
		puts
		Spreadsheet.client_encoding = 'UTF-8'
		location = read_string("File name: ")
		database = Spreadsheet.open location
		puts "Music Library Loaded                    ".colorize(:color => :green)
		read_string("Press ENTER.... ")
		finished = true
		system "clear" or system "cls"
	end until finished
	database
end


# =============================================================
# Read Album Data
# =============================================================
# Album
# Read Albums
def read_albums database_file
	album_database = database_file.worksheets
	albums = Array.new
	count = album_database.length.to_i
	i = 0
	while i < count 
		album = read_album(album_database[i])
		albums << album
		i += 1
	end
	albums
end
# Read Album
def read_album album_data
	album_id = album_data[0,1].to_i #=> 0: Row - 1:Column
	album_title = album_data[0,2].to_s
	album_artist = album_data[0,3].to_s
	album_genre = album_data[0,4].to_s
	tracks = read_tracks(album_data)

	album = Album.new(album_id ,album_title, album_artist, album_genre, tracks)
	album
end

# Track
# Read Tracks
def read_tracks album_data
	count = album_data[0,0].to_i + 1
	tracks = Array.new
	
	i = 1
	while i < count
		track = read_track(i, album_data)
		tracks << track
		i += 1
	end
	tracks
end

def read_track (index, album_data)
	id = album_data[index, 0].to_i
	title = album_data[index, 1].to_s
	location = album_data[index, 2].to_s
	track = Track.new(id, title, location)
	track
end




# =============================================================
# Display Album Data
# =============================================================
# Album
def print_albums_info albums
	system "clear" or system "cls"
	puts add_space('   Albums').colorize(:color => :white, :background => :blue)
	i = 0
	while i < albums.length
		album = albums[i]
		id = ' Album ID: ' + album.id.to_s
		genre = ' -= ' + album.genre + ' =-'
		title = ' > ' + album.title + ' by ' + album.artist
		puts add_space(' ').colorize(:color => :black, :background => :white)
		puts add_space(id).colorize(:color => :black, :background => :white)
		puts add_space(genre).colorize(:color => :red, :background => :white)
		puts add_space(title).colorize(:color => :red, :background => :white)
		i+=1
	end
	read_string("Press ENTER to continue.... ")
	system "clear" or system "cls"
end

def print_album_info album
	system "clear" or system "cls"
	puts add_space('   Albums').colorize(:color => :white, :background => :blue)
	id = ' Album ID: ' + album.id.to_s
	genre = ' -= ' + album.genre + ' =-'
	title = ' > ' + album.title + ' by ' + album.artist
	puts add_space(' ').colorize(:color => :black, :background => :white)
	puts add_space(id).colorize(:color => :black, :background => :white)
	puts add_space(genre).colorize(:color => :red, :background => :white)
	puts add_space(title).colorize(:color => :red, :background => :white)
	read_string("Press ENTER to continue.... ")
	system "clear" or system "cls"
end

def print_track_list album
	system "clear" or system "cls"
	puts add_space('   Track List').colorize(:color => :white, :background => :blue)
	i = 0
	while i < album.tracks.length
		track = album.tracks[i]
		text = ' ' + track.id.to_s + ' - ' + track.title
		puts add_space(text).colorize(:color => :red, :background => :white)
		i += 1
	end
end

def add_space string
	added_space_string = string
	if string.length < 60 
		count = 60 - string.length
		i = 0
		while i < count
			added_space_string += ' '
			i += 1
		end
	end
	added_space_string
end
  




# =============================================================
# Play Album
# =============================================================
def play_album albums
	id = read_integer('Album ID: ')
	valid, index = validate_id(id ,albums)
	if valid
		album = albums[index]
		print_track_list(album)
		play_track(album)
	else
		system "clear" or system "cls"
	end
end

def play_track (album)
	selected_track = read_integer_in_range("Play Track: ", 1, album.tracks.length)
	track = album.tracks[selected_track - 1]
	system "clear" or system "cls"
	puts add_space('     Playing').colorize(:color => :white, :background => :blue)
	puts add_space(' ').colorize(:color => :black, :background => :white)
	puts add_space('  ALBUM: ' + album.title).colorize(:color => :black, :background => :white)
	puts add_space('  ' + track.title).colorize(:color => :black, :background => :white)
	puts add_space(' ').colorize(:color => :black, :background => :white)
	command_string = 'open ' + track.location
	system(command_string)
	read_string("Press ENTER to continue.... ")
	system "clear" or system "cls"
end



# =============================================================
# Update Album
# =============================================================
def select_update_album albums
	system "clear" or system "cls"
	puts add_space('    Update Album').colorize(:color => :white, :background => :blue)
	puts add_space(' ').colorize(:color => :black, :background => :white)
	puts add_space(' Update an album\'s info.').colorize(:color => :black, :background => :white)
	puts add_space(' ').colorize(:color => :black, :background => :white)
	album_id = read_integer('Album ID: ')
	i = 0
	found = false
	while i < albums.length
		if album_id == albums[i].id
			found = true
			update_album(albums[i])
		end
		i += 1
	end
	if found == false
		puts "Unable to find an album with id: " + album_id.to_s
		read_string("Press ENTER to go back.... ")
	end
	system "clear" or system "cls"
	finished = true
end

def update_album album
	system "clear" or system "cls"
	finished = false
	begin
		puts add_space('    Update Album').colorize(:color => :white, :background => :blue)
		puts add_space('1 - Update Title').colorize(:color => :black, :background => :white)
		puts add_space('2 - Update Genre').colorize(:color => :black, :background => :white)
		puts add_space('3 - Update ID').colorize(:color => :black, :background => :white)
		puts add_space('4 - Back').colorize(:color => :black, :background => :white)
		choice = read_integer_in_range("Option: ", 1, 4) 
		case choice
		when 1
			update_album_title(album)
		when 2
			update_album_genre(album)
		when 3
			update_album_id(album)
		else
			finished = true
		end
	end until finished
end

def update_album_title album
	new_title = read_string('New Title: ')
	album.title = new_title
	album.updated = true
	print_album_info(album)
end

def update_album_genre album
	new_genre = read_string('New Genre: ')
	album.genre = new_genre
	album.updated = true
	print_album_info(album)
end

def update_album_id album
	new_id = read_integer('New ID: ')
	album.id = new_id
	album.updated = true
	print_album_info(album)
end

def isUpdated albums
	i = 0	
	updated = false
	if albums != nil
		count = albums.length
		while i < count 
			if albums[i].updated == true
				updated = true
			end
			i += 1
		end
	end
	updated
end

def validate albums
	valid = false
	if albums != nil
		valid = true
	else
		puts 'Please "Read in Album" first.'
		valid = false
	end
	valid
end

def validate_id (id, albums)
	valid = false
	index = -1
	i = 0
	count = albums.length
	while i < count 
		if albums[i].id == id
			valid = true
			index = i
			break
		end
		i += 1
	end
	return valid, index
end

def main
	system "clear" or system "cls"
	main_menu
end

main