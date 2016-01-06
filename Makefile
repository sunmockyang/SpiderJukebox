all:
	# SoundCloud
	@ruby SpiderJukebox.rb https://soundcloud.com/futuregirlfriendmusic/i-love-you
	@ruby SpiderJukebox.rb https://soundcloud.com/lonemoon/pandasssss
	@ruby SpiderJukebox.rb https://soundcloud.com/tomggg/kiwi-greedgreedtomggg-remix
	
	# mp3
	@ruby SpiderJukebox.rb "http://66.90.91.26/ost/ghost-in-the-shell-innocence-original-soundtrack/cojnlhrnmq/04-river-of-crystals.mp3"
	@ruby SpiderJukebox.rb "http://web.ist.utl.pt/antonio.afonso/www.aadsm.net/libraries/id3/music/Advent_Chamber_Orchestra_-_05_-_Dvorak_-_Serenade_for_Strings_Op22_in_E_Major_larghetto.mp3"
	@ruby SpiderJukebox.rb "http://web.ist.utl.pt/antonio.afonso/www.aadsm.net/libraries/id3/music/Bruno_Walter_-_01_-_Beethoven_Symphony_No_1_Menuetto.mp3"

	# Youtube
	@ruby SpiderJukebox.rb https://www.youtube.com/watch?v=ABbkd9ueKw8
	
	# Flags
	@ruby SpiderJukebox.rb https://soundcloud.com/futuregirlfriendmusic/i-love-you --title "Song of my People" --artist "Sunmock Yang"
	@ruby SpiderJukebox.rb -t "Bad Song" -a Unknown http://asdf.com
	@ruby SpiderJukebox.rb -f -t "Bad Song" -a Unknown http://asdf.com
	# @ruby SpiderJukebox.rb -h
