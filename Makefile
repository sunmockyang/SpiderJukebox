all: soundcloud mp3 youtube oembed flags

soundcloud:
	@ruby SpiderJukebox.rb https://soundcloud.com/futuregirlfriendmusic/i-love-you
	@ruby SpiderJukebox.rb https://soundcloud.com/lonemoon/pandasssss
	@ruby SpiderJukebox.rb https://soundcloud.com/tomggg/kiwi-greedgreedtomggg-remix

mp3:
	@ruby SpiderJukebox.rb "http://66.90.91.26/ost/ghost-in-the-shell-innocence-original-soundtrack/cojnlhrnmq/04-river-of-crystals.mp3"
	@ruby SpiderJukebox.rb "http://web.ist.utl.pt/antonio.afonso/www.aadsm.net/libraries/id3/music/Advent_Chamber_Orchestra_-_05_-_Dvorak_-_Serenade_for_Strings_Op22_in_E_Major_larghetto.mp3"
	@ruby SpiderJukebox.rb "http://web.ist.utl.pt/antonio.afonso/www.aadsm.net/libraries/id3/music/Bruno_Walter_-_01_-_Beethoven_Symphony_No_1_Menuetto.mp3"

youtube:
	@ruby SpiderJukebox.rb https://www.youtube.com/watch?v=ABbkd9ueKw8

oembed:
	@ruby SpiderJukebox.rb "http://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=l3NoYyNKSXQ&format=json"
	@ruby SpiderJukebox.rb "https://soundcloud.com/oembed?url=https%3A%2F%2Fsoundcloud.com%2Fforss%2Fflickermood&format=json"

flags:
	@ruby SpiderJukebox.rb https://soundcloud.com/futuregirlfriendmusic/i-love-you --title "Song of my People" --artist "Sunmock Yang"
	@ruby SpiderJukebox.rb -t "Bad Song" -a Unknown http://asdf.com
	@ruby SpiderJukebox.rb -f -t "Bad Song" -a Unknown http://asdf.com
	@ruby SpiderJukebox.rb -t "\"This file has no metadata\"" -a "\"Test for -p flag\"" -p MP3 https://archive.org/download/testmp3testfile/testmp3testfile_64kb.m3u
	@ruby SpiderJukebox.rb -h
	
