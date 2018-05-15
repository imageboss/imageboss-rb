module ImageBoss
  class Path
    SERVICE_URL = 'https://img.imageboss.me'.freeze
    OPERATIONS = {
      cover: {
        recipe: '/:operation::mode/:widthx:height/:options/', required: [:width, :height]
      },
      width: {
        recipe: '/:operation/:width/:options/', required: [:width]
      },
      height: { recipe: '/:operation/:height/:options/', required: [:height]},
      cdn: { recipe: '/:operation/:options/', required: [] }
    }.freeze

    def initialize(client_options, asset_path)
      @client_options = client_options
      @domain = client_options[:domain].chomp('/')
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
        @domain,
        @asset_path
      ].join
      parse(recipe)
    end
    private

    def parse(recipe)
      recipe
        .sub(':operation', @operation_name.to_s)
        .sub(':width', @options[:width].to_s)
        .sub(':height', @options[:height].to_s)
        .sub(':options', @extra_options.empty? ? '' : "#{@extra_options}/")
        .sub('::mode', @options[:mode] ? ":#{@options[:mode]}" : '').to_s
    end

    def parse_options(options = {})
      valid_options = [ :grayscale, :blur ]
      opts = []
      valid_options.each do |vo|
        opts << [vo.to_s, options[vo] ].join(':') if options && options.has_key?(vo)
      end
      opts.join(',')
    end
  end
end
