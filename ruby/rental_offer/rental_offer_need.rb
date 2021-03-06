#!/usr/bin/env ruby
# encoding: utf-8

# Docker run command:
#   docker run --name='workshop_need' -it -v /c/Users/fred/src/microservice_workshop/ruby:/workshop -w /workshop/rental_offer fredgeorge/ruby_microservice:latest bash
# To run monitor at prompt:
#   ruby rental_car_need.rb 192.168.59.103 bugs

require_relative 'rental_offer_need_packet'
require_relative 'connection'

# Expresses a need for rental car offers
class RentalOfferNeed

  def initialize(host, port, vhost_name)
    @host = host
    @port = port
    @vhost_name = vhost_name
  end

  def start
    Connection.with_open(@host, @port, @vhost_name) {|ch, ex| publish_need(ch, ex)}
  end

  private

  def publish_need(channel, exchange)
    loop do
      exchange.publish RentalOfferNeedPacket.new.to_json
      puts " [x] Published a rental offer need on the #{@vhost_name} bus"
      sleep 5
    end
  end

end

RentalOfferNeed.new(ARGV.shift, ARGV.shift, ARGV.shift).start
