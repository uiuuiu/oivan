require './config/environment'

class App < Sinatra::Base
  def self.public
    public_folder
  end

  set :root, File.expand_path(File.join(__FILE__, '..'))
  set :views, File.expand_path(File.join(__FILE__, '../views'))
  set :public, public_folder
  set :sprockets, Sprockets::Environment.new(root)
  set :assets_prefix, 'compiled'
  set :assets_path, File.join(root, 'public', assets_prefix)
  set :compass_gem_root, Gem.loaded_specs['compass'].full_gem_path
  set :digest_assets, false
  register(Sinatra::Cache)
  set :cache_enabled, true

  helpers Sinatra::HTMLEscapeHelper
  helpers Sinatra::AssetHelpers

  configure do
    # Setup Sprockets
    sprockets.append_path File.join(root, 'assets', 'stylesheets')
    sprockets.append_path File.join(root, 'assets', 'javascripts')
    sprockets.append_path File.join(root, 'assets', 'images')
    sprockets.js_compressor  = :uglify
    sprockets.css_compressor = :scss

    # Configure Sprockets::Helpers (if necessary)
    Sprockets::Helpers.configure do |config|
      config.environment    = sprockets
      config.prefix         = assets_prefix
      config.digest         = digest_assets
      config.public_path    = "#{root}/public"

      # Force to debug mode in development mode
      # Debug mode automatically sets
      # expand = true, digest = false, manifest = false
      # config.debug       = true if development?
    end
  end

  helpers do
    include Sprockets::Helpers

    # Alternative method for telling Sprockets::Helpers which
    # Sprockets environment to use.
    # def assets_environment
    #   settings.sprockets
    # end
  end

  get "/assets/*" do
    env["PATH_INFO"].sub!("/assets", "")
    settings.sprockets.call(env)
  end

  get "/" do
    @page = params[:page] || 1
    scanner = Data::Scanners::BestNewsScanner.new
    fetcher = Data::Fetcher.new
    @posts = fetcher.get_all(@page, scanner)
    slim :index
  end

  get "/posts" do
    @page = params[:page] || 1
    scanner = Data::Scanners::BestNewsScanner.new
    fetcher = Data::Fetcher.new
    @posts = fetcher.get_all(@page, scanner)
    slim :posts, layout: false, cache: false
  end

  get "/posts/:id" do
    scanner = Data::Scanners::BestNewsScanner.new
    @post = Post.find_by_id(params[:id])
    @content = scanner.scan_content(@post.link)
    slim :show
  end
end