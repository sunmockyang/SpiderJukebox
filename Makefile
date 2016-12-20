all: soundcloud mp3 youtube oembed vimeo flags

soundcloud:
	@echo soundcloud ---
	@ruby SpiderJukebox.rb https://soundcloud.com/futuregirlfriendmusic/i-love-you
	@ruby SpiderJukebox.rb https://soundcloud.com/lonemoon/pandasssss
	@ruby SpiderJukebox.rb https://soundcloud.com/tomggg/kiwi-greedgreedtomggg-remix
	@echo

mp3:
	@echo mp3 --- 
	@ruby SpiderJukebox.rb "http://66.90.91.26/ost/ghost-in-the-shell-innocence-original-soundtrack/cojnlhrnmq/04-river-of-crystals.mp3"
	@ruby SpiderJukebox.rb "http://web.ist.utl.pt/antonio.afonso/www.aadsm.net/libraries/id3/music/Advent_Chamber_Orchestra_-_05_-_Dvorak_-_Serenade_for_Strings_Op22_in_E_Major_larghetto.mp3"
	@ruby SpiderJukebox.rb "http://web.ist.utl.pt/antonio.afonso/www.aadsm.net/libraries/id3/music/Bruno_Walter_-_01_-_Beethoven_Symphony_No_1_Menuetto.mp3"
	@echo

youtube:
	@echo youtube ---
	@ruby SpiderJukebox.rb https://youtu.be/VyJkKn7A1w0
	@ruby SpiderJukebox.rb https://www.youtube.com/watch?v=l3NoYyNKSXQ
	@ruby SpiderJukebox.rb https://youtu.be/HZXTWXnBOWA
	@ruby SpiderJukebox.rb https://www.youtube.com/watch?v=Oxeoy03f4Oo
	@ruby SpiderJukebox.rb https://www.youtube.com/watch?v=3iWh0KbLtDw
	@ruby SpiderJukebox.rb https://www.youtube.com/watch?v=pB2uaNmu25U
	@echo

oembed:
	@echo oembed ---
	@ruby SpiderJukebox.rb "http://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=l3NoYyNKSXQ&format=json"
	@ruby SpiderJukebox.rb "https://soundcloud.com/oembed?url=https%3A%2F%2Fsoundcloud.com%2Fforss%2Fflickermood&format=json"
	@ruby SpiderJukebox.rb "https://vimeo.com/api/oembed.json?url=https://vimeo.com/177646448"
	@echo

vimeo:
	@echo vimeo ---
	@ruby SpiderJukebox.rb "https://vimeo.com/114099080"
	@ruby SpiderJukebox.rb https://vimeo.com/channels/staffpicks/152158147 #Dead link
	@echo

flags:
	@echo flags ---
	@ruby SpiderJukebox.rb https://soundcloud.com/futuregirlfriendmusic/i-love-you --title "Song of my People" --artist "Sunmock Yang"
	@ruby SpiderJukebox.rb -t "Bad Song" -a Unknown http://asdf.com
	@ruby SpiderJukebox.rb -f -t "Bad Song" -a Unknown http://asdf.com
	@ruby SpiderJukebox.rb -t "\"This file has no metadata\"" -a "\"Test for -p flag\"" -p MP3 https://archive.org/download/testmp3testfile/testmp3testfile_64kb.m3u
	@echo

help:
	@ruby SpiderJukebox.rb -h
	
