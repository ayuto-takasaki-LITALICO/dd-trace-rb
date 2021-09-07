# typed: true
module Datadog
  module Core
    module Environment
      # Reports Ruby VM cache performance statistics.
      # This currently encompasses cache invalidation counters and is
      # CRuby specific.
      #
      # TruffleRuby does not have runtime cache invalidation information.
      # TODO: find archive.org like for https://medium.com/graalvm/precise-method-and-constant-invalidation-in-truffleruby-4dd56c6bac1a
      #
      # JRuby emulates some CRuby cache statistics, but they are synthetic and don't
      # provide actionable performance information as cache invalidations
      # do not have a global impact in JRuby: https://github.com/jruby/jruby/issues/4384#issuecomment-267069314
      module VMCache
        module_function

        def global_method_state
          ::RubyVM.stat[:global_method_state]
        end

        def global_constant_state
          ::RubyVM.stat[:global_constant_state]
        end

        def available?
          defined?(::RubyVM) && ::RubyVM.respond_to?(:stat)
        end
      end
    end
  end
end
