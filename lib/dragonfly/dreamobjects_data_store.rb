require 'aws'
require 'dragonfly'

Dragonfly::App.register_datastore(:s3) { Dragonfly::DreamobjectsDataStore }

module Dragonfly
  class DreamobjectsDataStore
    def initialize(opts = {})
      @bucket_name       = options[:bucket_name]
      @access_key_id     = options[:access_key_id]
      @secret_access_key = options[:secret_access_key]
      @endpoint          = options.fetch(:endpoint, 'objects.dreamhost.com')
    end

    def write(content, opts = {})
    end

    private
    def ensure_configured
      unless @configured
        [:bucket_name, :access_key_id, :secret_access_key].each do |attr|
          if send(attr).nil?
            raise NotConfigured, "You need to configure #{self.class.name} with #{attr}"
          end
        end
      end
      @configured = true
    end
  end
end

