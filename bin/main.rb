#!/usr/bin/env ruby
require_relative '../lib/seo_lint.rb'


seo = SeoLint.new
seo.has_title?
seo.has_heading?