# SocialMail modules
require "./socialmail/modules/base"
require "./socialmail/modules/instagram"

# Other
require "./detection"

# Application initializer
require "option_parser"
require "crest"

module Socialmail
  VERSION = "0.1.0"

  email_addr = ""

  print <<-'EOF'
                          _       __                _ __
         _________  _____(_)___ _/ /___ ___  ____ _(_) /
        / ___/ __ \/ ___/ / __ `/ / __ `__ \/ __ `/ / / 
       (__  ) /_/ / /__/ / /_/ / / / / / / / /_/ / / /  
      /____/\____/\___/_/\__,_/_/_/ /_/ /_/\__,_/_/_/    
      ++ OSINT tool to detect email address registration on various networks
      - @author Halis Duraki <duraki@linuxmail.org>
      - @web    https://github.com/duraki/socialmail


  EOF

  OptionParser.parse do |parser|
    parser.banner = "Usage: socialmail -e [email] "
    parser.on("-e EMAIL", "--email=EMAIL", "Email to scan") { |email| email_addr = email }
    parser.on("-h", "--help", "Show this help") do
      puts parser
      exit
    end
    parser.invalid_option do |flag|
      STDERR.puts "ERROR: #{flag} is not a valid option."
      STDERR.puts parser
      exit(1)
    end
    if (ARGV.empty?)
      puts parser
    end
  end

  if (!email_addr.empty?)
    print "Detecting social networks [...] on email address: #{email_addr}\n"
    Detection.do_detection(email_addr)
  end
end
