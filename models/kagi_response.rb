class KagiResponse

  class << self
    def success(account)
      response("GOOD", "", account.email, account.serial)
    end

    def failed(message)
      response("BAD", message)
    end

    def response(status, message, email = "", serial = "")
      <<-TEXT
        Content-type: text/text

        kagiRemotePostStatus=#{status}, message="#{message}"

        userName=#{email}, regNumber=#{serial}
      TEXT
    end
  end
end

