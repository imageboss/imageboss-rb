module ImageBoss
  class Client
    def initialize(domain:, enabled: true)
      @options = {
        domain: domain,
        enabled: enabled
      }
    end

    def path(asset_path)
      Path.new(@options, asset_path)
    end
  end
end
