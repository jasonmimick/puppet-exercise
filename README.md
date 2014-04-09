puppet-exercise
===============

Challenge
1. Using your language or tool of choice automate the installation of a nginx web server, serving a website over port 8080, and populated using the data found athttps://github.com/puppetlabs/exercise-webpage. Please do not perform this exercise on the Windows operating system. Successful completion of this is an executable that reliably sets up the components needed to serve the content requested over port 8080, in a single run of and subsequent executions does not cause harm to functionality.
Attach the code you wrote to your response and answer the following questions. Limit your answers to a single page.

Questions
1. Describe the most difficult/painful hurdle you had to overcome in implementing your solution.
2. Describe which puppet related concept you think is the hardest for new users to grasp.
3. Where did you go to find information to help you in the build process?
4. In a couple paragraphs explain what automation means to you and why it is important to an organization's infrastructure design strategy.
Have fun and good luck. We look forward to receiving your completed tasks.

Challenge Design
----------------

 * Assumptions
	* Solution only needs to run on non-Windows operating systems. We'll assume either a REDHAT or Debian based system.
	* "an executable" - since puppet is an interpreted Ruby 'script' we'll build an 'execuatable' bash script

 * Dependencies
	* bash	- solution is a bash shell executable
	* curl	- curl used to download resources from the internet
	* package-manager (apt/yum) - to install nginx
	* 

 * Usage
	$puppet-exercise <command> <options>
	Available commands:
	  status	Display status
	  install	Install nginx and web-site
	  uninstall	Remove the installation
	
	Options:
	  --debug	Enable verbose debugging info
	  --install_dir	Override the PUPPET_EXERCISE_INSTALL_DIR evironment variable

	Environment variables:
	PUPPET_EXERCISE_INSTALL_DIR	Defaults to ./pup-ex-nginx

 * Design



