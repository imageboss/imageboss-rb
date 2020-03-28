module ImageBoss
  class Client
    def initialize(source:, enabled: true)
      @options = {
        source: source,
        enabled: enabled
      }
    end

    def path(asset_path)
      Path.new(@options, asset_path)
    end
  end
end
