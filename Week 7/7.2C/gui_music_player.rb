require 'rubygems'
require 'gosu'
require 'spreadsheet'

TOP_COLOR = Gosu::Color.new(0xFF1EB1FA)
BOTTOM_COLOR = Gosu::Color.new(0xFF1D4DB5)
TRACK_BACKGROUND = Gosu::Color::WHITE
RIGHT_PANEL_X = 600
RIGHT_PANEL_WIDTH = 400
RIGHT_PANNEL_HEIGHT = 600
TRACK_HEIGHT = 16

module ZOrder
  BACKGROUND, PLAYER, UI = *0..2
end

module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

GENRE_NAMES = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class ArtWork
	attr_accessor :bmp

	def initialize (file)
		@bmp = Gosu::Image.new(file)
	end
end

class Album
	attr_accessor :id, :title, :artist, :genre, :tracks, :artwork
	def initialize(id, title, artist, genre, tracks, artwork)
		@id = id
		@title = title
		@artist = artist
		@genre = genre
		@tracks = tracks
		@artwork = artwork
	end
end

class Track
	attr_accessor :id, :title, :location
	def initialize(id, title, location)
		@id = id
		@title = title
		@location = location
	end
end

class MusicPlayerMain < Gosu::Window

	def initialize
	    super 1000, 600
	    self.caption = "Music Player"

		# Reads in an array of albums from a file and then prints all the albums in the
		# array to the terminal
		@track_font = Gosu::Font.new(TRACK_HEIGHT)
		@title_font = Gosu::Font.new(24)
		@artist_font = Gosu::Font.new(20)
		@track_background = BOTTOM_COLOR
		@track_background_y = 70
		@current_album = -1
		@current_track = -1
		@song
		database = read_file
		@albums = read_albums(database)
		print_albums_debug(@albums)
	end

  # Put in your code here to load albums and tracks
	def read_file 
		Spreadsheet.client_encoding = 'UTF-8'
		database = Spreadsheet.open './albums.xls'
		database
	end

	def read_albums database
		album_database = database.worksheets
		albums = Array.new
		count = album_database.length
		i = 0
		while i < count
			album = read_album(album_database[i])
			albums << album
			i += 1
		end
		albums
	end

	def read_album album
		album_id = album[0,1].to_i #=> 0: Row - 1:Column
		album_title = album[0,2].to_s
		album_artist = album[0,3].to_s
		album_genre = album[0,4].to_s
		album_artwork = read_artwork(album[0,5].to_s)
		tracks = read_tracks(album)
		album = Album.new(album_id ,album_title, album_artist, album_genre, tracks, album_artwork)
		album
	end

	def read_artwork location
		artwork = ArtWork.new(location)
		artwork
	end

	def read_tracks album
		count = album[0,0].to_i + 1
		tracks = Array.new
		
		i = 1
		while i < count
			track = read_track(i, album)
			tracks << track
			i += 1
		end
		tracks
	end
	
	def read_track (index, album)
		id = album[index, 0].to_i
		title = album[index, 1].to_s
		location = album[index, 2].to_s
		track = Track.new(id, title, location)
		track
	end


  # Draws the artwork on the screen for all the albums

  def draw_albums albums
		# complete this code
		count = albums.length
		artworks = Array.new
		i = 0
		while i < count
			album = albums[i]
			artwork = album.artwork
			title = album.title
			artist = album.artist
			artworks << artwork
			# draw_title(title)
			# draw_artist(artist)
			# tracks = album.tracks
			# draw_tracks(tracks)
			i += 1
		end
		draw_artwork(artworks)
	end

	def draw_artwork(artworks)
		count = artworks.length
		if count > 1
			i = 0
			while i < count
				artwork = artworks[i]
				case i
				when 0
					artwork.bmp.draw_as_quad(0, 0, 0xff_ffffff, 300, 0, 0xff_ffffff, 0, 300, 0xff_ffffff, 300, 300, 0xff_ffffff, ZOrder::UI)
				when 1
					artwork.bmp.draw_as_quad(300, 0, 0xff_ffffff, 600, 0, 0xff_ffffff, 300, 300, 0xff_ffffff, 600, 300, 0xff_ffffff, ZOrder::UI)
				when 2
					artwork.bmp.draw_as_quad(0, 300, 0xff_ffffff, 300, 300, 0xff_ffffff, 0, 600, 0xff_ffffff, 300, 600, 0xff_ffffff, ZOrder::UI)
				when 3
					artwork.bmp.draw_as_quad(300, 300, 0xff_ffffff, 600, 300, 0xff_ffffff, 300, 600, 0xff_ffffff, 600, 600, 0xff_ffffff, ZOrder::UI)
				end
				i += 1
			end
		else count == 1
			artwork = artwork.bmp.draw_as_quad(0, 0, 0xff_ffffff, 600, 0, 0xff_ffffff, 0, 600, 0xff_ffffff, 600, 600, 0xff_ffffff, ZOrder::UI)
		end

	end

	def draw_title
		if @current_album != -1
			title = @albums[@current_album].title 
			@title_font.draw_markup(bold_text(title), RIGHT_PANEL_X + 20, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::WHITE)
		end
	end

	def draw_artist
		if @current_album != -1
			artist = @albums[@current_album].artist 
			@artist_font.draw_markup(italic_text('by ' + artist), RIGHT_PANEL_X + 20, 35, ZOrder::UI, 1.0, 1.0, Gosu::Color::WHITE)
		end
	end


	def draw_tracks
		if @current_album != -1
			tracks = @albums[@current_album].tracks 
			count = tracks.length
			i = 0
			while i < count 
				track = tracks[i]
				title = track.title
				draw_track((i+1).to_s + ' - ' + title, 70 + (i*26))
				i += 1
			end
		end
	end

  def draw_track(title, ypos)
  	@track_font.draw_text(title, RIGHT_PANEL_X + 20, ypos, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
	end
	
	def draw_track_background(index)
		Gosu.draw_rect(600, @track_background_y - 4, RIGHT_PANEL_WIDTH, TRACK_HEIGHT + 8, @track_background, ZOrder::BACKGROUND, mode=:default)
	end

	def selected_track index
		@track_background_y = (70 + (index*26))
		@track_background = TRACK_BACKGROUND
	end


	def playTrack(track, album)
		if (@current_track != track)
			if @song != nil
				@song.stop
			end
			@current_track = track
			@song = Gosu::Song.new(album.tracks[track].location)
			@song.play(false)
			puts "Play Track " + (track + 1).to_s
		else
			puts "Playing"
		end
  end

	def next_track
		if @song != nil
			if !@song.playing?
				if @current_track != -1
					next_track_index = @current_track + 1
					if next_track_index <= @albums[@current_album].tracks.length
						selected_track(next_track_index)
						playTrack(next_track_index, @albums[@current_album])
						@current_track = next_track_index
					end
				end
			end
		end
	end

	def reset
		if @song != nil
			@song.stop
		end
		@current_track = -1
		@track_background_y = 70
		@track_background = BOTTOM_COLOR
	end

	def area_clicked (mouse_x, mouse_y)
		# Select Album
		count = @albums.length
		if count > 1
			if (mouse_x > 0 && mouse_x < 300) && (mouse_y > 0 && mouse_y < 300)
				@current_album = 0
				reset
			end
			if (mouse_x > 300 && mouse_x < 600) && (mouse_y > 0 && mouse_y < 300)
				@current_album = 1
				reset
			end
			if (mouse_x > 0 && mouse_x < 300) && (mouse_y > 300 && mouse_y < 600)
				@current_album = 2
				reset
			end
			if (mouse_x > 300 && mouse_x < 600) && (mouse_y > 300 && mouse_y < 600)
				@current_album = 3
				reset
			end
		elsif count == 1
			if (mouse_x > 0 && mouse_x < 600) && (mouse_y > 0 && mouse_y < 600)
				@current_album = 0
			end
		end

		if (mouse_x > 600 && mouse_x < 1000)
			index = ((mouse_y - 70) / 26).round
			if @current_album != -1
				album_index = @current_album
				if (index >= 0 && index < @albums[album_index].tracks.length)
					selected_track(index)
					playTrack(index, @albums[album_index])
				end
			end
		end
	end


# Draw a coloured background using TOP_COLOR and BOTTOM_COLOR

	def draw_background
		Gosu.draw_rect(0, 0, 1000, 600, BOTTOM_COLOR, ZOrder::BACKGROUND, mode=:default)
	end

	def draw_right_panel
		Gosu.draw_rect(RIGHT_PANEL_X, 0, RIGHT_PANEL_WIDTH, RIGHT_PANNEL_HEIGHT, BOTTOM_COLOR, ZOrder::BACKGROUND, mode=:default)
	end

	def update
		next_track
	end

 # Draws the album images and the track list for the selected album

	def draw
		draw_background
		draw_right_panel
		draw_albums(@albums)
		draw_track_background(-1)
		draw_title
		draw_artist
		draw_tracks
	end

 	def needs_cursor?; true; end

	def button_down(id)
		case id
	    when Gosu::MsLeft
				area_clicked(mouse_x, mouse_y)
	    end
	end

	# *************************************
	# Support Functions
	# *************************************
	def bold_text text
		return '<b>' + text + '</b>'
	end

	def italic_text text
		return '<i>' + text + '</i>'
	end

	def add_space string
		added_space_string = string
		if string.length < 60 
			count = 60 - string.length
			i = 0
			added_space_string += ' '
			while i < count
				added_space_string += '*'
				i += 1
			end
		end
		added_space_string
	end

	# *************************************
	# Debug
	# *************************************
	def print_albums_debug albums
		i = 0
		count = albums.length
		album_count = '**** No. of Album: ' + count.to_s
		puts
		puts add_space('******************')
		puts add_space(album_count)
		while i < count
			album_title = '**** ' + (i + 1).to_s + ' - ' + albums[i].title
			puts add_space(album_title)
			i += 1
		end
		puts add_space('******************')
		puts 
	end

end

# Show is a method that loops through update and draw

MusicPlayerMain.new.show if __FILE__ == $0
