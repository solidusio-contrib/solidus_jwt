module SolidusJwt
  MAJOR = 0
  MINOR = 1
  PATCH = 0
  PRERELEASE = nil

  def self.version
    version = [MAJOR, MINOR, PATCH].join('.')
    [version, PRERELEASE].compact.join('.')
  end
end
