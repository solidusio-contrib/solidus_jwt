module SolidusJwt
  MAJOR = 0
  MINOR = 0
  PATCH = 1
  PRERELEASE = 'pre'.freeze

  def self.version
    version = [MAJOR, MINOR, PATCH].join('.')
    [version, PRERELEASE].compact.join('.')
  end
end
