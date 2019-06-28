# csshui

  
Perl script interface to use cssh cluster servers. It was tested with OSX and csshX, but I think it could work with cssh for linux.  
  
How to change your */etc/clusters* file  
  
This is a sample configuration  
  

    # AMAZON AWS  
    PRO-amazon-php serverone servertwo  
    PRO-amazon-cgi serverthree serverfour  
    # DIGITAL OCEAN SERVERS  
    TEST-servers servertestone servertesttwo servertestthree  

  
This is the interface shown:  
  
    Here are the defined clusters. Choose the one you want to connect to:  
    
    # AMAZON AWS  
    1 => PRO-amazon-php  
    2 => PRO-amazon-cgi  
    # DIGITAL OCEAN SERVERS  
    3 => TEST-servers  
    x => exit  

  
You have to select the option, a number, or "x" (to exit), and hit enter.  
  
If the server starts with "PRO", it will be shown en red color. Others will be shown in green color.  
  
Every line that starts with "#", it will be shown in yellow color. I use this lines as "group" of servers.
