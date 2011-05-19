#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

$LOAD_PATH << 'lib'

IRC_ENCODING='sjis'

require 'rubygems'
require 'net/irc'
require 'pp'
require 'socket'
require 'kconv'

class IRCBot < Net::IRC::Client
	
	def initialize(*args)
		super
	end
	
	def on_rpl_welcome(m)
		#post JOIN, "#kefir".encode(IRC_ENCODING).force_encoding('external')
	end
	
	def on_invite(m)
		post JOIN, m[1].encode(IRC_ENCODING).force_encoding('external')
	end
	
	def on_privmsg(m)
		
		msg = m[1].toutf8
		
		if msg =~ /(?:か|ね|の)[?？]/u then
			send_msg = m.prefix.nick + ': いいえ、ケフィアです。'
			post PRIVMSG, m[0], send_msg.tosjis
		end
	end
end

IRCBot.new("irc.huie.hokudai.ac.jp", 6667, {
	:nick => "kefir_bot", 
	:user => "kefir",
	:real => "kefir"
}).start;




