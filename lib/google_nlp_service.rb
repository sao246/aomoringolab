# NLP呼び出し用プログラム 2025/05/05

require 'base64' # 画像やバイナリデータ送信用エンコード
require 'json' # Google APIのデータ形式はJSON指定。
require 'net/https' # GoogleのAPIは HTTPS通信 を使ってアクセスする必要があるため設定。

module GoogleNlpService
  class << self
    def get_entities(text)
      # API通信を行うエンドポイントのURL（リクエストデータの送信先）を指定する。今回はanalyzeEntitiesを指定する。
      api_url = "https://language.googleapis.com/v1/documents:analyzeEntities?key=#{ENV['GOOGLE_API_KEY']}"

      # APIリクエスト用のJSONパラメータをここで作成。
      params = {
        document: { #送るデータが文書である
          type: 'PLAIN_TEXT', #プレーンテキスト（平文）であることを記載
          content: text
        },
        encodingType: 'UTF8'
      }.to_json

      # Google Cloud Natural Language APIに送るリクエストデータ部分の作成
      uri = URI.parse(api_url) #送信先のGoogleの住所を確認するために、URLを分解
      https = Net::HTTP.new(uri.host, uri.port) # データをどこに出すか設定
      https.use_ssl = true # SSL認証の設定
      request = Net::HTTP::Post.new(uri.request_uri) #HTTPメソッドはPOSTで送る
      request['Content-Type'] = 'application/json' # JSON形式で送ることを指定
      response = https.request(request, params) # ここでリクエスト送信。（と同時にリクエストに対するレスポンスの結果を変数に格納）

      # Googleから受け取ったAPIレスポンスデータを出力させる
      response_body = JSON.parse(response.body)

      if (error = response_body['error']).present?
        raise error['message']
      else
        response_body['entities'] # エンティティの配列を返す
      end
    end
  end
end
