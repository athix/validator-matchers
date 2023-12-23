module Validator
  module Matchers
    def self.gem_version
      Gem::Version.new VERSION::STRING
    end

    module VERSION
      MAJOR = 0
      MINOR = 0
      PATCH = 4

      STRING = [MAJOR, MINOR, PATCH].join('.')
    end
  end
end
