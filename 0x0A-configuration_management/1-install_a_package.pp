# Ensure pip is up-to-date
exec { 'update-pip':
  command => '/usr/bin/python3 -m pip install --upgrade pip',
  unless  => '/usr/bin/python3 -m pip freeze | grep pip==21.0.1', # Example, replace with your desired version check
  path    => ['/bin', '/usr/bin'],
}

# Update setuptools
exec { 'update-setuptools':
  command => '/usr/bin/python3 -m pip install --upgrade setuptools',
  unless  => '/usr/bin/python3 -m pip freeze | grep setuptools==50.0.0', # Example, replace with your desired version check
  require => Exec['update-pip'], # Ensure pip is updated first
  path    => ['/bin', '/usr/bin'],
}

# Ensure the correct version of werkzeug is installed
package { 'werkzeug':
  ensure   => '1.0.1', # Example, adjust the version as necessary for Flask 2.1.0
  provider => 'pip3',
  require  => Exec['update-setuptools'], # Ensure setuptools is updated first
}

# Install Flask
package { 'flask':
  ensure   => '2.1.0',
  provider => 'pip3',
  require  => Package['werkzeug'], # Ensure werkzeug is installed first
}

