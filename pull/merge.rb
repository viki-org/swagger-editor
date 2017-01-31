#!/usr/bin/env ruby

require 'yaml'
require 'json'

if __FILE__ == $0
  global_api_doc = {'swagger' => '2.0', 'host' => 'api-staging.viki.net', 'basePath' => '/v4'}
  global_api_doc['info'] = {}
  global_api_doc['info']['title'] = "Platform API"
  global_api_doc['info']['version'] = "v4"
  global_api_doc['info']['contact'] = {}
  global_api_doc['info']['contact']['name'] = 'platform@viki.com'
  global_api_doc['securityDefinitions'] = {}


  global_api_doc['securityDefinitions']['ClientId'] = {}
  global_api_doc['securityDefinitions']['ClientId']['type'] = 'apiKey'
  global_api_doc['securityDefinitions']['ClientId']['name'] = 'app'
  global_api_doc['securityDefinitions']['ClientId']['in'] = 'query'
  global_api_doc['securityDefinitions']['ClientId']['description'] = ''\
       'Register your application at the **Viki application dashboard**.'\
       ''\
       'You may use your normal Viki account or create a separate account to manage your applications. You will be granted a **Client ID** and a **Client Secret**.'

  global_api_doc['securityDefinitions']['ClientSecret'] = {}
  global_api_doc['securityDefinitions']['ClientSecret']['type'] = 'apiKey'
  global_api_doc['securityDefinitions']['ClientSecret']['name'] = 'secret'
  global_api_doc['securityDefinitions']['ClientSecret']['in'] = 'header'

  global_api_doc['securityDefinitions']['Token'] = {}
  global_api_doc['securityDefinitions']['Token']['type'] = 'apiKey'
  global_api_doc['securityDefinitions']['Token']['name'] = 'token'
  global_api_doc['securityDefinitions']['Token']['in'] = 'query'
  global_api_doc['securityDefinitions']['Token']['description'] = ''\
  ''\
  '     Login a user to obtain a user access token.'\
  ''\
  '     **POST /v5/sessions.json**'\
  ''\
  '     *Params*'\
  '       * username'\
  '       * password'\
  ''\
  '     Example: `{\"username\": \"tyler\",\"password\": \"relyt\"}`'\
  ''\
  '     The returned value includes two fields: token and user. The token acts like a session id, and should be included in any subsequent user-specific requests via token=TOKEN. The user   field in general information about the user.'


  folder = File.join('/opt', 'swagger-editor', 'pull', 'repos', '*' , 'docs', '*.yaml')
  puts folder
  defaults = global_api_doc.keys
  global_api_doc['paths'] = {}

  Dir.glob(folder) do |file|
    puts file
    api = YAML::load(File.read(file))
    api.each do |key, value|
      if defaults.include?(key)
        puts "Debug: ignoring #{key}, #{value.inspect}"
        next
      end
      if key == 'paths'
        value.each do |path, methods|
          if global_api_doc['paths'].has_key? path
            global_api_doc['paths'][path].merge methods
          else
            global_api_doc['paths'][path] = methods
          end
        end
      elsif value.is_a? Hash
        existing = global_api_doc.fetch(key, {})
        global_api_doc[key] = existing.merge(value)
      elsif value.is_a? Array
        existing = global_api_doc.fetch(key, [])
        global_api_doc[key] = (existing + value).uniq
      end
    end
  end

  output_file = ARGV[0].nil? ? '/opt/swagger-editor/spec-files/test.yaml' : ARGV[0]
  puts output_file
  File.open(output_file, 'w') do |fp|
    fp.write global_api_doc.to_yaml
  end
end
