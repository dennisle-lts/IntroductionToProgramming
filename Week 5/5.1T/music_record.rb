require './input_functions'

module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

$genre_names = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class Album
  attr_accessor :title, :artist, :genre
  def initialize(_title, _artist, _genre)
    @title = _title
    @artist = _artist
    @genre = _genre
  end
end

def read_album
  album_title = "Let There Be Rock"
  album_artist = "AC/DC"
  album_genre = $genre_names[Genre::ROCK]
  album = Album.new(album_title, album_artist, album_genre)
  album
end

def print_album album
  puts('Album information is: ')
  puts 'Title: ' + album.title
  puts 'Artist: ' + album.artist
  puts 'Genre: ' + album.genre.to_s
end

def main
  album = read_album()
	print_album(album)
end

main
