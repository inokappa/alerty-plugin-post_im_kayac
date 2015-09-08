# Alerty::Plugin::PostImKayac

[im.kayac.com](http://im.kayac.com/) plugin for [alerty](https://github.com/sonots/alerty).

## Spcial Thanks

I used the blog post & source code below as reference. Thank you!!!

- http://blog.livedoor.jp/sonots/archives/45330651.html
- [alerty-plugin-amazon_sns](https://github.com/sonots/alerty-plugin-amazon_sns)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'alerty-plugin-post_im_kayac'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install alerty-plugin-post_im_kayac

## Configuration

following is required.

- **type** : must be post_im_kayac
- **user_name** : im_kayac User Name
- **password** : im_kayac Password
- **access_key** : AWS Access Key 
- **secret_access_key** : AWS Secret Access Key 
- **aws_region** : AWS Region Name
- **s3_bucket** : S3 Bucket Name
- **bitly_user_name** : Bitly User Name
- **bitly_api_key** : Bitly API Key
- **subject** : subject of alert. ${command} is replaced with a given command, ${hostname} is replaced with the hostname ran a command

following is an example.

```
log_path: STDOUT
log_level: debug
plugins:
  - type: post_im_kayac
    user_name: your_im_kayac_user_name
    password: your_im_kayac_password
    access_key_id: AKxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    secret_access_key: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    aws_region: ap-northeast-1
    s3_bucket: your_s3_bucket_name
    bitly_user_name: bitly_user_name
    bitly_api_key: bitly_api_key
    subject: "FAILURE: [${hostname}] ${command}"
```

See [examle.yml](https://github.com/inokappa/alerty-plugin-post_im_kayac/blob/master/example.yml).

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/alerty-plugin-post_im_kayac.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

