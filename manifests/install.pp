
define rvm::install() {
  exec {
    "download rvm for ${name}" :
      creates => "/home/${name}/.rvm/scripts/rvm",
      cwd     => "/home/${name}",
      command => 'curl -L get.rvm.io -o install-rvm.sh',
      user    => $name,
      path    => ['/bin', '/usr/bin'],
      notify  => Exec["install rvm for ${name}"],
      require => User[$name];

    "install rvm for ${name}" :
      creates     => "/home/${name}/.rvm/scripts/rvm",
      command     => 'bash -s stable < install-rvm.sh',
      cwd         => "/home/${name}",
      user        => $name,
      environment => ["HOME=/home/${name}"],
      provider    => shell,
      logoutput   => on_failure,
      refreshonly => true,
      path        => ['/bin', '/usr/bin', '/sbin', '/usr/sbin'],
      require     => User[$name];
  }
}
