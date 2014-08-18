module Grook

	class ThreadQueue
	
		attr_reader :enabled
		
		def initialize
			@_work_queue = Queue.new
		end
		
		def add_work(prok)
			@_work_queue << prok
		end

		def run
			@enabled = true
			@_loop = Thread.new {
				Thread.handle_interrupt(RuntimeError => :on_blocking) {
					while true
						unless @_work_queue.empty?
							prok = @_work_queue.pop(true) rescue nil	
							prok.call if prok.class == Proc
						end
						break if enabled==false
						sleep(1)
					end
				}
			}
		end

		def stop
			@enabled=false
		end

	end

end

