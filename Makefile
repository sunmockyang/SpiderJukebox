all:
	# SoundCloud
	@ruby SpiderJukebox.rb https://soundcloud.com/futuregirlfriendmusic/i-love-you
	@ruby SpiderJukebox.rb https://soundcloud.com/lonemoon/pandasssss
	@ruby SpiderJukebox.rb https://soundcloud.com/tomggg/kiwi-greedgreedtomggg-remix
	
	# mp3
	@ruby SpiderJukebox.rb "http://66.90.91.26/ost/ghost-in-the-shell-innocence-original-soundtrack/cojnlhrnmq/04-river-of-crystals.mp3"

	# Youtube
	@ruby SpiderJukebox.rb https://www.youtube.com/watch?v=ABbkd9ueKw8
	
	# Flags
	@ruby SpiderJukebox.rb https://soundcloud.com/futuregirlfriendmusic/i-love-you --title "Song of my People" --artist "Sunmock Yang"
	@ruby SpiderJukebox.rb -t "Bad Song" -a Unknown http://asdf.com
	@ruby SpiderJukebox.rb -f -t "Bad Song" -a Unknown http://asdf.com
	# @ruby SpiderJukebox.rb -h
