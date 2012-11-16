class KagiResponse

  class << self
    def success(accounts)
      response("GOOD", "", accounts)
    end

    def failed(message)
      response("BAD", message)
    end

    def response(status, message, accounts = [])
      licences = accounts.map do |account|
        <<-TEXT

          userName=#{account.email}, regNumber=#{account.serial}
        TEXT
      end.join

      header(status, message) + licences
    end

    private

    def header(status, message)
      <<-TEXT
        Content-type: text/text

        kagiRemotePostStatus=#{status}, message="#{message}"
      TEXT
    end
  end
end

