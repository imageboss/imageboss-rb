module ImageBoss
  class Client
    def initialize(domain:)
      @domain = domain
    end

    def path(asset_path)
      Path.new(@domain, asset_path)
    end
  end
end
