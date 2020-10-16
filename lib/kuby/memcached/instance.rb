require 'kube-dsl'

module Kuby
  module Memcached
    class Instance
      extend ::KubeDSL::ValueFields

      attr_reader :name, :environment

      value_field :version, default: '1.5.4-v1'
      value_field :port, default: 11211

      def initialize(name, environment)
        @name = name
        @environment = environment
      end

      def resources
        @resources ||= [memcached]
      end

      def hostname
        name
      end

      def url
        @url ||= "#{hostname}:#{port}"
      end

      def memcached(&block)
        context = self

        @memcached ||= Kuby::KubeDB.memcached do
          api_version 'kubedb.com/v1alpha1'

          metadata do
            name "#{context.name}-memcached"
            namespace context.kubernetes.namespace.metadata.name
          end

          spec do
            version context.version

            service_template do
              spec do
                type 'NodePort'
                port do
                  name 'redis'
                  port context.port
                end
              end
            end
          end
        end

        @memcached.instance_eval(&block) if block
        @memcached
      end

      def kubernetes
        environment.kubernetes
      end
    end
  end
end
