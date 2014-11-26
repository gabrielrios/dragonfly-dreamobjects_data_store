require 'aws'
require 'pry'
require 'dragonfly'

Dragonfly::App.register_datastore(:dreamobjects) { Dragonfly::DreamobjectsDataStore }

module Dragonfly
  class DreamobjectsDataStore
    def initialize(options = {})
      @bucket_name       = options[:bucket_name]
      @access_key_id     = options[:access_key_id]
      @secret_access_key = options[:secret_access_key]
      @endpoint          = options.fetch(:endpoint, 'objects.dreamhost.com')
    end

    def write(content, opts={})
      uid = opts[:path] || generate_uid(content.name || 'file')
      bucket.objects[uid].write(content.data,
                                metadata: { json: Serializer.json_encode(content.meta)})
      uid
    end

    # # Retrieve the data and meta as a 2-item array
    def read(uid)
      object = bucket.objects[uid]
      data = object.read
      meta = Serializer.json_decode(object.metadata[:json])
        [
          data,     # can be a String, File, Pathname, Tempfile
          meta      # the same meta Hash that was stored with write
        ]
    end

    def destroy(uid)
      bucket.objects[uid].delete
    end

    def create_bucket(name)
      storage.buckets.create(name)
    end

    private
    def storage
      @storage ||= AWS::S3.new(access_key_id: @access_key_id,
                              secret_access_key: @secret_access_key,
                              s3_endpoint: @endpoint,
                              use_ssl: false,
                              s3_force_path_style: true)
    end

    def bucket
      @bucket ||= storage.buckets[@bucket_name]
    end

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

    def generate_uid(name)
      "#{Time.now.strftime '%Y/%m/%d/%H/%M/%S'}/#{rand(1000)}/#{name.gsub(/[^\w.]+/, '_')}"
    end
  end
end

