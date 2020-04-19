module ImageBoss
  class Client
    def initialize(source:, enabled: true, secret: false)
      @options = {
        source: source,
        enabled: enabled,
        secret: secret
      }
    end

    def path(asset_path)
      Path.new(@options, asset_path)
    end
  end
end
