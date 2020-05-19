module Socialmail
  class Instagram < Base
    MODULE_NAME  = %q{INSTAGRAM}
    MODULE_URL   = %q{https://www.instagram.com}
    ENDPOINT_URL = %q{https://www.instagram.com/accounts/password/reset/}

    # # Confirmation Bias
    ENDPOINT_BIAS = %q{https://www.instagram.com/accounts/account_recovery_send_ajax/}
    BIAS_REQ_MET  = :post

    getter registered : Bool = false

    def initialize(@email_address : String)
      super(MODULE_NAME, @email_address)
      do_req
      has_account(@registered)
    end

    def create_body
      {
        :email_or_username         => @email_address,
        :recaptcha_challenge_field => "",
      }
    end

    # Notice: This request is NOISY! It will send account recovery email to the
    # target. We can bypass this by trying to register account with the same email.
    # xxx: impl technique via account registration
    def do_req
      request = Crest::Request.new(
        BIAS_REQ_MET,
        ENDPOINT_BIAS,
        headers: {
          "accept"           => "*/*",
          "accept-encoding"  => "gzip, deflate, br",
          "content-type"     => "application/x-www-form-urlencoded",
          "dnt"              => "1",
          "origin"           => "https://www.instagram.com",
          "referer"          => "https://www.instagram.com/accounts/password/reset/",
          "sec-fetch-dest"   => "empty",
          "sec-fetch-mode"   => "cors",
          "sec-fetch-site"   => "same-origin",
          "x-csrftoken"      => "BSkRrZVrZpY406FN3hp0tO1OyCGFQn1W",
          "x-ig-app-id"      => "936619743392459",
          "x-ig-www-claim"   => "0",
          "x-instagram-ajax" => "4369ea5acc56",
          "x-requested-with" => "XMLHttpRequest",
          "user-agent"       => user_agent,
          "cookie"           => cookie,
        },
        form: create_body
      )

      begin
        resp = request.execute
        if resp.status_code == 200
          @registered = true
        end
      rescue ex : Crest::BadRequest # => Email not registered
        @sregistered = false
      end
    end

    def teq
      {
        "[app] InstagramOSINT"        => "https://github.com/sc1341/InstagramOSINT",
        "[app] InstaLooter"           => "https://github.com/althonos/InstaLooter",
        "[pub] Geolocation Technique" => "https://www.researchgate.net/publication/322952183_Geo-Location_Twitter_And_Instagram_Based_On_OSINT_Techniques_A_Case_Study",
      }
    end

    private def cookie
      %q{ig_did=44582520-1FFC-437A-92EE-5AFAF739B30F; csrftoken=BSkRrZVrZpY406FN3hp0tO1OyCGFQn1W; mid=XsOWsgAEAAHX6bJhJ2kwQCf_wTpZ}
    end
  end
end
