puppet-exercise <img height="50" width="100" style="float: left" src="http://puppetlabs.com/sites/default/files/PL_logo_horizontal_RGB_0.svg"/> 
===============
### Challenge ###
  Using your language or tool of choice automate the installation of a nginx web server, serving a website over port 8080, and populated using the data found at
https://github.com/puppetlabs/exercise-webpage. 
Please do not perform this exercise on the Windows operating system. 
Successful completion of this is an executable that reliably sets up the components needed to serve the content requested over port 8080, in a single run of and subsequent executions does not cause harm to functionality.

Attach the code you wrote to your response and answer the following questions. Limit your answers to a single page.

### Questions ###
1. Describe the most difficult/painful hurdle you had to overcome in implementing your solution.

  The most difficult part was deciding on whether to install nginx from prebuilt binaries or build from source. 
I opted to build from source, since using the various package managers would make it more difficult to control where things install and require lots of checking to see what kind of a system the tool is running on (Debian/Red Hat/etc). 
This choice means there are dependecies on development tools such as gcc, make, etc. The solution checks for these dependencies and reports if they are not found.

2. Describe which puppet related concept you think is the hardest for new users to grasp.

  I would imagine that new users could have some difficulty in applying the abstract notion of a "Resource" across many kinds of objects on a system, such as services, users, files, etc. Many users would be accustomed to thinking of these objects as quite different.
The good news is that once past this fundamental hurdle the rest of the concepts should fall into place quite easliy.

3. Where did you go to find information to help you in the build process?

  I just used Google to find nginx source and configuration info and also to lookup various bash script syntax stuff I couldn't remember.

4. In a couple paragraphs explain what automation means to you and why it is important to an organization's infrastructure design strategy.

  Automation is the process of enabling systems, software, and processes to act independently. 
Consider the scenario of launching a new software product; typically this requires multiple new servers for development and testing. 
In a non-automated world, dozens of manual steps are required - allocation of hardware and operating systems, application of policies, dependecy checks, etc. 
These tasks then need to be repeated multiple times for each server.
Automation frameworks reduce tasks like this to "pushing a button". 

  We're prone to make mistakes when attempting to repeat complicated technical tasks. 
That's why we have computers and why automation is so important.
By automating processes organizations are able to reduce risk, prevent accidents, and focus on core business goals rather than "housework". 
Successful modern enterprises react quickly and confidently, in part, because they've automated wherever possible. 
In utilizing a consistent automation framework tangential infrastructure tasks are commoditized. Meaning, the amount of effort spent on tasks such as server and software builds, testing, and deployment is minimized. The task of rapidly scaling up or down can be quantified and thus assuredly executed. 
Automation frameworks also enable the application of sound engineering practices to operational tasks. 
Your product, infrastructure, and processes all become "code" - something which technologists understand.
Additionally, the actual process of automating things produces de facto documentation of the process itself. 
Rather then encoding processes in Word documents and then implementing them in another medium, the two are merged. 
The days of "the spec is outdated" are in the rearview mirror. 

  It is quick to see the potential impact of automation frameworks. 
Not only are errors reduced and new features rolled out quicker, the effort needed to manage infrastructure is reduced. 
Embracing automation results in a smoother running organization able to quickly and successfully meet the demands of customers.
 

Have fun and good luck. We look forward to receiving your completed tasks.

### Challenge Solution ###

  The solution to this challenge is the 'puppet-exercise.sh' script found in this repository.

 * Assumptions
	* Solution only needs to run on non-Windows operating systems. We'll assume a typical Linux system.
	* "an executable" - since puppet is a Ruby 'script' we'll build an 'executable' bash script

 * Dependencies
	* bash	- solution is a bash shell executable
	* curl	- curl used to download resources from the internet
	* development tools - cc, make, etc to build nginx from source 

 * Usage
<pre>
usage: puppet-exercise [-h|--help] &lt;command&gt; &lt;install_dir&gt;
puppet-exercise installs an instance of nginx to &lt;install_dir&gt; and configures it to serve on port 8080.
If &lt;install_dir&gt; is not specified, then components are installed into ./pup-ex.
Artifacts are downloaded to ./.pup-ex.
Details of installation can be found in ./.pup-ex/install.log.
Available commands are:
  status  	Displays information on installation
  install 	Installs nginx and web-site
  uninstall	Removes the installation
</pre>

 * Design


  The program flows as follows:
  
  * Parse and validate command line parameters
  * Execute command, if found
    	* status	
			- Attempt to get status of nginx server running from <install_dir> 
           and report to user
    	* install	
			- If already installed, report and do nothing
			- Remove any contents of ./.pup-ex
			- Download nginx and web-site into ./.pup-ex
			- Unpack and build nginx
			- Install nginx into &lt;install_dir&gt;/nginx-root
			- Update nginx configuration to listen on port 8080
			- Copy web-site into &lt;install_dir&gt;/nginx-root/html
			- Record actions in ./.pup-ex/install.log and &lt;install_dir&gt;/puppet-exersice-info
    	* uninstall	
			- Stop nginx if running
			- Remove contents of &lt;install_dir&gt; 

 * Future

  The most obvious feature to add would be to parameterize the web server port and the sources for nginx and the web-site. Additional TODOs could be to support OS X (get nginx build to work and refactor use of 'readlink -f').
 
Questions/Comments?		jmimick@gmail.com
