require "colorize"

module Socialmail
  class Base
    # Base Module class
    def initialize(@module_name : String, @email_address : String)
      print "Initializing new module ... [#{module_name}] #{@email_address} OK.\n"
    end

    def user_agent
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36"
    end

    def has_account(is_registered : Bool)
      color = is_registered ? :green : :red

      print "   |\n"
      print "   +-- [#{@module_name}] has_account: #{is_registered}\n".colorize(color)
      if (is_registered)
        print "      |\n"

        teq.each do |technique|
          print "      +-> #{technique[0]}: #{technique[1]}\n"
        end
      end
    end
  end
end
