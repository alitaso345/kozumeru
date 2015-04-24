# 顔認識docomoAPIで画像の中に人の顔があるか判定するスクリプト
require 'rest_client'
require 'json'

API_KEY = ENV['DOCOMO_API_KEY']

    @uri = URI('https://api.apigw.smt.docomo.ne.jp/puxImageRecognition/v1/faceDetection')
    @uri.query = 'APIKEY=' + API_KEY
    response = RestClient.post(
      @uri.to_s,
      {
        :imageURL => 'http://pbs.twimg.com/media/CDSCIvdUsAAQvxL.jpg',
        :response => 'json'
    },
      :content_type => 'application/x-www-form-urlencoded'
    )
    hash = JSON.parser.new(response).parse()
    p hash["results"]["faceRecognition"]["detectionFaceNumber"]
