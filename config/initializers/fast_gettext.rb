# encoding: utf-8

FastGettext.add_text_domain 'app', :path => 'locale', :type => :po
FastGettext.default_text_domain = 'app'
FastGettext.default_available_locales = ['en', 'ru', 'uk', 'br']