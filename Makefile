all:
	# SoundCloud
	@ruby SpiderJukebox.rb https://soundcloud.com/futuregirlfriendmusic/i-love-you
	
	# Youtube
	@ruby SpiderJukebox.rb https://www.youtube.com/watch?v=ABbkd9ueKw8
	
	# Flags
	@ruby SpiderJukebox.rb https://soundcloud.com/futuregirlfriendmusic/i-love-you --title "Song of my People" --artist "Sunmock Yang"
	@ruby SpiderJukebox.rb -t "Bad Song" -a Unknown http://asdf.com
	@# @ruby SpiderJukebox.rb -h
