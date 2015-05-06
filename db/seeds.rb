#メイドさんの情報をDBに投入する
Maid.import_info_from_homepage

#メイドさん全員のツイート情報を最小限だけ取得
client = TwitterClient
client.get_seed_tweets
