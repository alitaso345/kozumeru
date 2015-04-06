#crawler maid tweet
every :hour do
  runner "Tweet.import_recent_tweet"
end
