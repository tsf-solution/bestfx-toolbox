classdef style
    
    properties (Constant)
        DEBUG = true;
    end
    
    methods(Static)
        
        function reset
            import me.sl.style
            style.model();
            style.block('depth',0,'reset',true);
        end
        
        function apply
            import me.sl.style
            depth = 0;
            style.model();
            style.block('depth',depth);
            style.inport(depth);
            style.outport(depth);
            style.logic(depth);
            style.math(depth);
            style.terminator(depth);
            style.constant(depth);
            style.saturate(depth);
            style.relay(depth);
            style.ratelimiter(depth);
            style.switches(depth);
            style.delay(depth);
            style.typecast(depth);
            style.ratetransition(depth);
            style.enable(depth);
        end
    end

    methods(Access=private, Static)
        % prototypes
        model()
        block(varargin)
        inport(depth)
        outport(depth)
        logic(depth)
        math(depth)
        terminator(depth)
        constant(depth)
        saturate(depth)
        relay(depth)
        ratelimiter(depth)
        switches(depth)
        delay(depth)
        typecast(depth)
        ratetransition(depth)
        enable(depth)
    end
end
