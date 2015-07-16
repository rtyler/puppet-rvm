define rvm::install() {
  exec {
     "import rvm gpg keys" :
      cwd         => "/home/${name}",
      command     => 'curl -sSL https://rvm.io/mpapis.asc | gpg --import -',
      user        => $name,
      environment => ["HOME=/home/${name}"],
      provider    => shell,
      path        => ['/bin', '/usr/bin', '/sbin', '/usr/sbin'],
      notify      => Exec["download rvm for ${name}"],
      require     => User[$name];

   "download rvm for ${name}" :
      creates => "/home/${name}/.rvm/scripts/rvm",
      cwd     => "/home/${name}",
      command => 'curl -L get.rvm.io -o install-rvm.sh',
      user    => $name,
      path    => ['/bin', '/usr/bin'],
      notify  => Exec["install rvm for ${name}"],
      require => [User[$name], Exec["import rvm gpg keys"]];

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
      require     => [User[$name], Exec["download rvm for ${name}"]];
  }
  file {
    "/home/${name}/.rvm/archives" :
      ensure  => directory,
      require => Exec["install rvm for ${name}"],
      mode    => '0755',
      owner   => $name,
      group   => $name;
  }
}
