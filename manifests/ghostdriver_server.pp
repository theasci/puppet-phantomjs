# Adds init script and service declaration for running the Ghostdriver server
class phantomjs::ghostdriver_server (
  $enable = true,
  $user = 'selenium',
  $ip_and_port = '127.0.0.1:8080',
  $selenium_hub_url = 'http://127.0.0.1:4444',
  $log_file = '',
  $log_level = 'INFO',
) {
  file { '/etc/init.d/ghostdriver':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('phantomjs/ghostdriver.init.erb'),
  } ~>
  service { 'ghostdriver':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => $enable,
    require    => File["${phantomjs::install_dir}/phantomjs"],
  }
}
