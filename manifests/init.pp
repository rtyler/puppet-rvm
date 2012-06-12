
class rvm {
  # Requirements needed for building rubies and friends
  package {
    ['bison', 'openssl', 'libssl-dev', 'libreadline5', 'libreadline-dev',
    'libcurl4-openssl-dev'] :
      ensure => present
  }

  if (!defined(Package['build-essential'])) {
    package {
      'build-essential' :
        ensure => present;
    }
  }

  if (!defined(Package['autoconf'])) {
    package {
      'autoconf' :
        ensure => present;
    }
  }
}
