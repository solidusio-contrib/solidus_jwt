module SolidusJwt
  MAJOR = 1
  MINOR = 0
  PATCH = 0
  PRERELEASE = 'beta1'

  def self.version
    version = [MAJOR, MINOR, PATCH].join('.')
    [version, PRERELEASE].compact.join('.')
  end
end
