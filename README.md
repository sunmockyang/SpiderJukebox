# SpiderJukebox
Simply put, a cross-service music metadata interface. Spiders manipulate web and this is their jukebox.

## Usage
You provide SpiderJukebox with a url for audio, and optionally specific metadata to override the audio's metadata and it will return metadata that was parsed from the url.
##### Note: Some/all of the parsers need a developer API key to access their APIs. You will need to obtain API keys for your usage.
### Command line
``` bash
ruby SpiderJukebox.rb [url] [options]
```
Specific options:
```
-t, --title=TITLE                Override the title of the track.
-a, --artist=ARTIST              Override the artist of the track.
-r, --album_art=ALBUMART         Override the album art url of the track.
-d, --duration=DURATION          Override the duration (ms) of the track.
-f, --force                      Force create track without valid url
-h, --help                       Show this message
```
Outputs a formatted string (I'll add an option so that it'll spit out JSON). Check out the `Makefile` to see it in use.

### Ruby API
``` ruby
SpiderJukebox.parse(url, options)
```
##### `url` = string such as "https://soundcloud.com/lonemoon/pandasssss"

##### `options` = a hash containing the following keys:
``` ruby
source: nil, # A string set by the parser of which service the url points to
title: "", # Title of the track
artist: "", # Artist of the track
url: "", # Provided url
art_url: "", # Album cover art url
duration_ms: 0, # Duration of the media
force: false # When set to true, a track will be output with the above metdata despite no valid parser being found
```
All options above can be set in the options argument and will override the output track's metadata, except `:force`.

#### Examples
##### Get metadata from url
``` ruby
SpiderJukebox.parse("https://soundcloud.com/tomggg/kiwi-greedgreedtomggg-remix")
# => {"source":"SoundCloud","title":"KiWi - GreedGreed(Tomggg Remix)","artist":"Tomggg","url":"https://soundcloud.com/tomggg/kiwi-greedgreedtomggg-remix","art_url":"https://i1.sndcdn.com/artworks-000109770992-h2w6gs-large.jpg","duration_ms":228697}
```
##### Override a track's metadata
``` ruby
SpiderJukebox.parse("https://soundcloud.com/tomggg/kiwi-greedgreedtomggg-remix", artist:"Sunmock")
# => {"source":"SoundCloud","title":"KiWi - GreedGreed(Tomggg Remix)","artist":"Sunmock","url":"https://soundcloud.com/tomggg/kiwi-greedgreedtomggg-remix","art_url":"https://i1.sndcdn.com/artworks-000109770992-h2w6gs-large.jpg","duration_ms":228697}
```
##### Output a track despite invalid url
``` ruby
SpiderJukebox.parse("http://invalid-url-dot-com", artist: "Unknown", title: "Bad Song", force: true)
# => {"source":null,"title":"Bad Song","artist":"Unknown","url":"http://invalid-url-dot-com","art_url":"","duration_ms":0}
```


## Parser implementation
* Under `Parsers/` there are different types of parsers that can be used to output a specific track.
* I'll expand on this some other day, but in the meantime, look at the `SpiderParser` class in `SpiderParser.rb` and you'll find an interface you can use.
* So far `SoundCloudParser` is the only parser that's been implemented. See this for help
* Parser wishlist:
  * Youtube
  * Bandcamp
  * Any other services you'd normally use
* My vision for this is that people will fork this repo and make their own parsers that they can merge in through PRs to extend the Jukebox.
