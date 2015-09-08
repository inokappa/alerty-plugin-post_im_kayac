require 'alerty'
require 'im-kayac'
require 'aws-sdk-resources'
require 'bitly'
require 'dotenv'
require 'net/http'
Dotenv.load

class Alerty
  class Plugin
    class PostImKayac
      def initialize(config)
	params = {}
	params[:region] = config.aws_region if config.aws_region
        params[:access_key_id] = config.aws_access_key_id if config.aws_access_key_id
        params[:secret_access_key] = config.aws_secret_access_key if config.aws_secret_access_key
        params[:ssl_verify_peer] = false
	@s3 = Aws::S3::Resource.new(params)
	@s3_bucket = config.s3_bucket
        @subject = config.subject
        @user_name = config.user_name
        @password = config.password
        @num_retries = config.num_retries || 3
	Bitly.use_api_version_3
	@bitly = Bitly.new(config.bitly_user_name, config.bitly_api_key)
      end

      def alert(record)
        message = record[:output]
        subject = expand_placeholder(@subject, record)
        retries = 0
	log_url = put_log_to_s3(message)
        begin
          ImKayac.to(@user_name).handler(log_url).password(@password).post(subject)
          Alerty.logger.info "Sent #{{subject: subject, url: log_url}} to im.kayac and #{log_url}"
        rescue => e
          retries += 1
          sleep 1
          if retries <= @num_retries
            retry
          else
            raise e
          end
        end
      end

      private

      def expand_placeholder(str, record)
        str.gsub('${command}', record[:command]).gsub('${hostname}', record[:hostname])
      end

      def put_log_to_s3(message)
	obj = @s3.bucket(@s3_bucket).object('KeyName')
	url = URI.parse(obj.presigned_url(:put))
	Net::HTTP.start(url.host) do |http|
          http.send_request("PUT", url.request_uri, message, {
            "content-type" => "",
          })
        end
	page_url = obj.presigned_url(:get, expires_in: 600)
	@bitly.shorten(page_url).short_url
      end

    end
  end
end

