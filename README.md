puppet-exercise
===============

Challenge
1. Using your language or tool of choice automate the installation of a nginx web server, serving a website over port 8080, and populated using the data found athttps://github.com/puppetlabs/exercise-webpage. Please do not perform this exercise on the Windows operating system. Successful completion of this is an executable that reliably sets up the components needed to serve the content requested over port 8080, in a single run of and subsequent executions does not cause harm to functionality.
Attach the code you wrote to your response and answer the following questions. Limit your answers to a single page.

Questions
1. Describe the most difficult/painful hurdle you had to overcome in implementing your solution.

  The most difficult part was deciding on whether to install nginx from prebuilt binaries or to build from source. I opted to build from source, since using the various package managers would make it more difficult to control where things install and would also require lots of checking to see what kind of a system the tool is running on (Debian/Red Hat/etc). The most painful hurdle was adding all the error handling to gracefully tell users what's wrong.

2. Describe which puppet related concept you think is the hardest for new users to grasp.

3. Where did you go to find information to help you in the build process?

  Just used Google searches to find nginx source and configuration info and also to lookup various bash script syntax stuff I couldn't remember.

4. In a couple paragraphs explain what automation means to you and why it is important to an organization's infrastructure design strategy.

  Automation is the process of enabling systems, software, and processes to act independently. For example, consider the scenario of a developement team starting a new project and requiring a new development server. In a non-automated world, dozens of manual steps would be required - allocation of hardware, operating system installation and update, application of corporate security policies, dependecy checks, etc. Automation frameworks reduce tasks like this to "pushing a button". Each step in a process is automated and made repeatable. Smaller tasks can be joined together to quickly build new more complex automations.

  Automation is important for a variety of reasons, the first and foremost however is that humans are prone to make mistakes - especially when attempting to repeat a complex task. By automating processes organizations are able to reduce risk, prevent accidents, and focus on business goals rather than "housework". Modern enterprises need to be able to react quickly and confidently to be successful. By utilizing a consistent automation framework tangential tasks can be commoditized to a degree. Meaning, the amount of effort spent on tasks such as software builds, testing and deployment is reduced. The task of rapidly scaling up or down can be quantified and thus assuredly executed. Additionally, automation frameworks enable sound engineering practices to be applied to operational tasks. Your product, your infrastructure, and your processes all become "code" - something which technologists understand.

  It is quick to see the potential impact of automation frameworks. Not only are errors reduced and new features rolled out quicker, the amount of resources needed to manage infrastructure is reduced. These resources can then be redirected to tasks which directly effect your businesses bottom-line. Organizations can also benefit from the auto-documentation which results from automation. The actual processes of automating things produces a defacto documentation of the process itself. Rather then encoding processes in Word documents and then implementing in another medium the two are merged. The days of "the spec is outdated" are in the rearview mirror. Embracing automation allows organizations to quickly reap these kind of benefits leading to happier employees and customers.  
  

Have fun and good luck. We look forward to receiving your completed tasks.

Challenge Design
----------------

 * Assumptions
	* Solution only needs to run on non-Windows operating systems. We'll assume either a REDHAT or Debian based system.
	* "an executable" - since puppet is an interpreted Ruby 'script' we'll build an 'executable' bash script

 * Dependencies
	* bash	- solution is a bash shell executable
	* curl	- curl used to download resources from the internet
	* development tools - cc, make, etc to build nginx from source 

 * Usage
	$puppet-exercise [-h|--help] [-v|--verbose] <command> <options>
	Available commands:
	  status	Display status
	  install	Install nginx and web-site
	  uninstall	Remove the installation
	
	Options:
	  --install_dir	Override the PUPPET_EXERCISE_INSTALL_DIR evironment variable

	Environment variables:
	PUPPET_EXERCISE_INSTALL_DIR	Defaults to ./pup-ex-nginx

 * Design


  The program flows as follows:
  
  1) Parse can validate command line parameters
  2) Execute command
    status	- Attempt to get status of nginx server running from PUPPET_EXERCISE_INSTALL_DIR
		  and report to user
    install	- If already installed, report and do nothing
		- Remove any contents of ./.pup-ex
		- Download nginx and web-site into ./.pup-ex
		- Unpack and install to PUPPET_EXERCISE_INSTALL_DIR
		- Record actions in ./.pup-ex/log
    uninstall	- Stop nginx if running
		- Remove contents of PUPPET_EXERCISE_INSTALL_DIR

