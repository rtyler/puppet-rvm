
class rvm {
  # Requirements needed for building rubies and friends
  package {
    ['build-essential', 'bison', 'openssl',
    'libssl-dev', 'libreadline5', 'libreadline-dev',
    'autoconf', 'libcurl4-openssl-dev'] :
      ensure => present
  }
}
