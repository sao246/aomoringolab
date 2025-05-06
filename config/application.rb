require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Aomoringolab
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    
    # 日本時間（JST）に設定 2025/04/15
    config.time_zone = 'Tokyo' # ビュー・コントローラ表示用の時間設定
    config.active_record.default_timezone = :local # DB保存の時間設定

    # lib フォルダ内のファイルを自動的に読み込む(Google API処理用に追加)
    # API処理ロジックで追加したlibフォルダのソースはRailsの自動読み込みが効かないためにこの設定が必要。
    # Wの設定：配列作成時に ["a", "b", "c"] の形式にするため！
    config.autoload_paths += %W(#{config.root}/lib)

    # 本番環境でAPI接続するためのenvファイルの設定を入れる 2025/05/06
    Dotenv.load('.env', '.env.production')
  end
end