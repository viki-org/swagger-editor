#!/usr/bin/env ruby

require 'yaml'

if __FILE__ == $0
   global_api_doc = {swagger: '2.0', host: 'api-staging.viki.net', basePath: '/v4/'}
   folder = File.join('pull', 'repos', '*' , 'docs', '*.yaml')
   Dir.glob(folder) do |file|
     puts file
     api = YAML::load(File.read(file))
     api.each do |key, value|
       if value.is_a? Hash
         existing = global_api_doc.fetch(key, {})
         global_api_doc[key] = existing.merge(value)
       elsif value.is_a? Array
         existing = global_api_doc.fetch(key, [])
         global_api_doc[key] = (existing + value).uniq
       elsif !global_api_doc.has_key?(key.to_sym)
         puts "Debug: ignoring #{key}, #{value.inspect}"
       end
     end
   end
   File.open('spec-files/default.yaml', 'w') do |fp|
     fp.write global_api_doc.to_yaml
   end
end
