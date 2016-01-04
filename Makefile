all:
	# SoundCloud
	@ruby SpiderJukebox.rb https://soundcloud.com/futuregirlfriendmusic/i-love-you
	@ruby SpiderJukebox.rb https://soundcloud.com/lonemoon/pandasssss
	@ruby SpiderJukebox.rb https://soundcloud.com/tomggg/kiwi-greedgreedtomggg-remix
	
	# Youtube
	@ruby SpiderJukebox.rb https://www.youtube.com/watch?v=ABbkd9ueKw8
	
	# Flags
	@ruby SpiderJukebox.rb https://soundcloud.com/futuregirlfriendmusic/i-love-you --title "Song of my People" --artist "Sunmock Yang"
	@ruby SpiderJukebox.rb -t "Bad Song" -a Unknown http://asdf.com
	@ruby SpiderJukebox.rb -f -t "Bad Song" -a Unknown http://asdf.com
	# @ruby SpiderJukebox.rb -h
