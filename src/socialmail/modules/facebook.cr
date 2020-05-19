module Socialmail
  class Facebook < Base
    MODULE_NAME  = %q{FACEBOOK}
    MODULE_URL   = %q{https://www.facebook.com}
    ENDPOINT_URL = %q{https://www.facebook.com/login/identify/?ctx=recover/}

    # # Confirmation Bias
    ENDPOINT_BIAS = %q{https://www.facebook.com/ajax/login/help/identify.php?ctx=recover}
    BIAS_REQ_MET  = :post

    getter registered : Bool = false

    def initialize(@email_address : String)
      super(MODULE_NAME, @email_address)
      do_req
      has_account(@registered)
    end

    def create_body
      {
        :jazoest     => "2642",
        :lsd         => "AVrP9iP7",
        :email       => @email_address,
        :did_submit  => "Search",
        :__user      => "0",
        :__a         => "1",
        :__dyn       => "7xe6Fo4OQ1PyUbFuC1swgE98nwgU6C7UW3q327E2vwXx60kO4o3Bw5VCwjE3awbG783pwlU7i0n2US1kyE1lUK2218w5axe0SU2swdq0Ho",
        :__csr       => "",
        :__req       => "6",
        :__beoa      => "0",
        :__pc        => "PHASED:DEFAULT",
        :dpr         => "1",
        :__ccg       => "GOOD",
        :__rev       => "1002143154",
        :__s         => "thiy84:wxs1j6:51azyj",
        :__hsi       => "6828510931997411027-0",
        :__comet_req => "0",
        :__spin_r    => "1002143154",
        :__spin_b    => "trunk",
        :__spin_t    => "1589886595",
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
          "accept"          => "*/*",
          "accept-encoding" => "gzip, deflate, br",
          "content-type"    => "application/x-www-form-urlencoded",
          "dnt"             => "1",
          "origin"          => "https://www.facebook.com",
          "referer"         => "https://www.facebook.com/login/identify/?ctx=recover",
          "sec-fetch-dest"  => "empty",
          "sec-fetch-mode"  => "cors",
          "sec-fetch-site"  => "same-origin",
          "user-agent"      => user_agent,
          "cookie"          => cookie,
        },
        form: create_body
      )

      begin
        resp = request.execute
        if resp.status_code == 200
          @registered = true
          pp resp.body.set_encoding("UTF-8")

          exit
        end
      rescue ex : Crest::BadRequest # => Email not registered
        @sregistered = false
      rescue ex
        @registered = false
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
      %q{sb=J77DXmE1Rfc_w1sYtmpiahv6; datr=J77DXu0VC_WYzMfngOelxmqg; wd=1800x392; dpr=0.800000011920929; fr=1Goqr4ZlBifHjpRND..Bew74n.02.AAA.0.0.Bew756.AWX07ckE}
    end
  end
end
