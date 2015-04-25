class DocomoAPI
  def initialize
    api = Rails.application.secrets[:docomo_api_key] 
    @uri = URI('https://api.apigw.smt.docomo.ne.jp/puxImageRecognition/v1/faceDetection')
    @uri.query = 'APIKEY=' + api
  end

#渡された画像URLに顔が写っているかどうかを判定
  def face_judgement(picture_url)
    response = RestClient.post(
      @uri.to_s,
      {
        :imageURL => picture_url,
        :response => 'json'
    },
      :content_type => 'application/x-www-form-urlencoded'
    )
    hash = JSON.parser.new(response).parse()
    p hash["results"]["faceRecognition"]["detectionFaceNumber"]
  end
end
