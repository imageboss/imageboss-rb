module ImageBoss
  class Path
    require 'uri'
    require 'openssl'

    SERVICE_URL = 'https://img.imageboss.me'.freeze
    OPERATIONS = {
      cover: {
        recipe: '/:source/:operation::mode/:widthx:height/:options/', required: [:width, :height]
      },
      width: {
        recipe: '/:source/:operation/:width/:options/', required: [:width]
      },
      height: { recipe: '/:source/:operation/:height/:options/', required: [:height]},
      cdn: { recipe: '/:source/:operation/:options/', required: [] }
    }.freeze

    def initialize(client_options, asset_path)
      @client_options = client_options
      @service_url = client_options[:service_url] || SERVICE_URL
      @source = client_options[:source]
      @secret = client_options[:secret]
      @asset_path = asset_path
    end

    def operation(name, options = {})
      return @asset_path unless @client_options[:enabled]

      @operation_name = name.to_sym
      @options = options
      @extra_options = parse_options(options[:options])
      @operation = OPERATIONS[@operation_name]
      @required = @operation[:required]

      @required.each do |r|
        @options.fetch(r)
      end

      recipe = [
        SERVICE_URL,
        @operation[:recipe].chomp('/'),
        @asset_path.gsub(/^\/?(.+)/, "\\1")
      ].join

      recipe_url = parse(recipe)
      recipe_path = parse(recipe).gsub(SERVICE_URL, '')
      @secret == false ? recipe_url : add_params(recipe_url, { bossToken: create_token(recipe_path) })
    end

    private

    def create_token(path)
      OpenSSL::HMAC.hexdigest('sha256', @secret, path)
    end

    def add_params(url, params = {})
      uri = URI(url)
      params    = Hash[URI.decode_www_form(uri.query || '')].merge(params)
      uri.query =      URI.encode_www_form(params)
      uri.to_s
    end

    def parse(recipe)
      recipe
        .sub(':source', @source.to_s)
        .sub(':operation', @operation_name.to_s)
        .sub(':width', @options[:width].to_s)
        .sub(':height', @options[:height].to_s)
        .sub(':options', @extra_options.empty? ? '' : "#{@extra_options}/")
        .sub('::mode', @options[:mode] ? ":#{@options[:mode]}" : '').to_s
    end

    def parse_options(options)
      opts = []
      (options || {}).each_key do |k|
        options[k] = k.to_s == "wmk-path" ? CGI.escape(options[k]) : options[k]
        opts << [k.to_s, options[k] ].join(':')
      end
      opts.join(',')
    end
  end
end
