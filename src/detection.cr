module Socialmail
  module Detection
    def self.do_detection(email_address : String)
      Socialmail::Instagram.new(email_address)
    end
  end
end
