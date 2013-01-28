require 'eventmachine'
require 'fiber'
module Minitest
  module EMSync
    VERSION = '0.1.0'
    def setup
      super()
      @current_fiber = Fiber.current
      @em_reactor = Fiber.new do
        begin
          EM.run do
            @current_fiber.transfer
          end
        rescue => e
          @current_fiber.transfer e
        end
      end
      em_transfer
    end

    def sync(df)
      f = Fiber.current
      res = nil
      xback = proc do |*args|
        if f == Fiber.current && args.first.is_a?(Exception)
          raise args.first
        elsif f == Fiber.current
          res = args.size == 1 ? args.first : args
        else
          f.transfer(*args)
        end
      end

      df.callback(&xback)
      df.errback(&xback)

      if res
        res
      else
        em_transfer
      end
    end

    def teardown
      super()
      done
    end

    def done
      return unless @em_reactor.alive?
      EM.next_tick { EM.stop }
      em_transfer unless @em_reactor == Fiber.current
    end

    def em_transfer
      res = @em_reactor.transfer
      raise res if res.is_a? Exception
      res
    end
  end
end
