module Socialmail
  class Instagram < Base
    MODULE_NAME  = %q{INSTAGRAM}
    MODULE_URL   = %q{https://www.instagram.com}
    ENDPOINT_URL = %q{https://www.instagram.com/accounts/password/reset/}

    # # Confirmation Bias
    ENDPOINT_BIAS = %q{https://www.instagram.com/accounts/account_recovery_send_ajax/}
    BIAS_REQ_MET  = %q{POST}
    BIAS_REQ_BODY = %q{email_or_username=%s&recaptcha_challenge_field=}

    def initialize(@email_address : String)
    end

    def create_body : String
      BIAS_REQ_BODY % [@email_address]
    end
  end
end
