#!/bin/bash -f
# 
# puppet-exercise.sh
# jmimick@gmail.com
#
# A simple script to download and install an nginx web server and
# a static web-site form github
#

# stop running if any errors
set -e  

# helper routines start
usage()
{
    cat << 'end-of-usage'
usage: puppet-exercise [-h|--help] <command> <install_dir>

Install an instance of nginx to <install_dir> and configure it to serve on port 8080.
If <install_dir> is not specified, then nginx will install to ./pup-ex.
Artifacts are downloaded to ./.pup-ex.
Details of installation can be found in ./.pup-ex/install.log.

Available commands are:
  status  	Displays information on installation
  install 	Installs nginx and web-site
  uninstall	Removes the installation

end-of-usage
}

# report the status of a puppet-exercise.sh installation
# usage: status <path to puppet-exercise install>
status()
{
  dir=$1
  if [ ! -f $dir/puppet-exercise-info ]; then
    echo "$dir does not appear to be a valid puppet-exercise installation."
    return
  fi
  cat $dir/puppet-exercise-info
  if [ -e $dir/nginx-root/logs/nginx.pid ]; then
    nginx_pid=$(cat $dir/nginx-root/logs/nginx.pid)
    started_at=$(ps -o stime= -p 27409)
    echo "nginx pid=$nginx_pid running, started at $started_at"
  else
    echo "nginx not running from $arg/nginx-root"
  fi
}

# installs nginx and web-site to a directory
# usages: install <dest> 
install() 
{
  arg=$1
  # If already installed, do nothing!
  if [ -d "$arg/nginx-root" ]; then
      echo "nginx already installed to $arg"
    return
  fi
  mkdir $arg
  echo "puppet-exercise started at $(date)" > $arg/puppet-exercise-info
  current_dir=$(pwd)
  rm -rf ./.pup-ex
  mkdir ./.pup-ex
  install_log=$(readlink -f ./.pup-ex/install.log)
  touch $install_log
  cd ./.pup-ex
  # download source
  nginx_src="http://nginx.org/download/nginx-1.5.13.tar.gz"
  website_src="https://github.com/puppetlabs/exercise-webpage"
  curl -vs -X GET -O $nginx_src 2>$install_log 
  echo "Downloaded nginx source from: $nginx_src" >> $arg/puppet-exercise-info
  git clone $website_src > $install_log 2>&1
  echo "Cloned web site from $website_src" >> $arg/puppet-exercise-info
  # unpack and build nginx
  tar xf nginx-1.5.13.tar.gz
  cd nginx-1.5.13 
  ./configure --prefix=$arg/nginx-root --without-http_rewrite_module --without-http_gzip_module --without-http_proxy_module \
	> $install_log 2>&1
  make >> $install_log 2>&1
  make install >> $install_log 2>&1
  # update nginx config
  sed -i 's/        listen       80;/        listen       8080;/' $arg/nginx-root/conf/nginx.conf
  echo "Updated nginx config to listen on port 8080" >> $arg/puppet-exercise-info
  # copy web-site files to serve
  cd $current_dir
  cp ./.pup-ex/exercise-webpage/index.html $arg/nginx-root/html/index.html
  # crank her up
  $arg/nginx-root/sbin/nginx
  echo "Started nginx on port 8080."
  echo "puppet-exercise done at $(date)" >> $arg/puppet-exercise-info
}

uninstall() 
{
  rm -rf $1 
}
#end of helper routines

# main script
options=$@
arguments=($options)
index=0
command=0
command_arg=0
for arg in $options
do
  index=`expr $index + 1`
  case $arg in
    -h|--help) usage 
               exit;;
  install) command="install" 
           command_arg=${arguments[index]};;
  uninstall)  command="uninstall"
           command_arg=${arguments[index]};;
      status) command="status"
           command_arg=${arguments[index]};;
  esac
done

if [ $command = 0 ]; then 
  echo "No command found"
  usage
  exit
fi

if [ -z $command_arg ]; then
   command_arg=$(readlink -f .)/pup-ex
else 
   command_arg=$(readlink -f $command_arg)
fi

case $command in 
  status)
    status $command_arg;;
  install)
    install $command_arg;;
  uninstall)
    uninstall $command_arg;;
esac
