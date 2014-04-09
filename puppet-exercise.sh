#!/bin/bash -f

usage()
{
    cat << 'end-of-usage'
usage: puppet-exercise [-h|--help] [-v|--verbose] <command> <install_dir>

Install an instance of nginx to <install_dir> and configure it to serve on port 8080.

Available commands are:
  status	Display status
  install	Install nginx and web-site
  uninstall	Remove the installation

end-of-usage
}

# helper routines start
config()
{
  git config --get-regexp shed
}

status()
{
	echo "status"
}
remove_dir()
{
	dir=$1
	debug=$2
	if [ $debug = 1 ]; then 
		rmflags="rf"
	else
		rmflags="rfv"
	fi
	rm -$rmflags $dir
}
download()
{
	url=$1
	dest=$2
	debug=$3
	if [ $debug = 1 ]; then
		verbose="-v"
	else
		verbose=""
	fi
	cd $dest
	curl $verbose -X GET -O $url 
	cd -
}

install() 
{
	arg=$1
	debug=$2
	echo "install arg=$arg debug=$debug"
	remove_dir $arg $debug
	remove_dir ./.pup-ex $debug
	mkdir ./.pup-ex
	nginx_src="http://nginx.org/download/nginx-1.5.13.tar.gz"
	website_src="https://github.com/puppetlabs/exercise-webpage"
	download $nginx_src ./.pup-ex $debug
	cd ./.pup-ex
	git clone $website_src
	cd -	
	tar xvf ./.pup-ex/nginx-1.5.13.tar.gz
}

uninstall() 
{
	$arg=$1
	$debug=$1
	echo "uninstall arg=$arg debug=$debug"
}
#end of helper routines

# main script
options=$@
arguments=($options)
index=0
command=0
command_arg=0
namespace=0
debug=0
for arg in $options
do
  index=`expr $index + 1`
  case $arg in
    -v|--verbose) debug=1;;
    -h|--help) usage 
               exit;;
  install) command="install" 
           command_arg=${arguments[index]};;
  uninstall)  command="uninstall"
           command_arg=${arguments[index]};;
      status) status
			  exit;;
  esac
done

if [ $command = 0 ]; then 
  echo "No command found"
  usage
  exit
fi


case $command in 
  install)
	install $command_arg $debug;;
  uninstall)
    uninstall $command_arg $debug;;
esac
