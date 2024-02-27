classdef style
    
    properties (Constant)
        DEBUG = true;
    end
    
    methods(Static)
        
        function reset
            import me.sl.style
            style.model();
            style.block('depth',1,'reset',true);
        end
        
        function apply
            import me.sl.style
            depth = Inf;
            style.model();
            style.block('depth',depth);
            style.inport(depth);
            style.outport(depth);
            style.buscreator(depth);
            style.busselector(depth);
            style.mux(depth);
            style.demux(depth);
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
        buscreator(varargin)
        busselector(varargin)
        constant(depth)
        delay(depth)
        demux(depth)
        enable(depth)
        inport(depth)
        logic(depth)
        math(depth)
        mux(depth)
        outport(depth)
        ratelimiter(depth)
        ratetransition(depth)
        relay(depth)
        saturate(depth)
        switches(depth)
        terminator(depth)
        typecast(depth)
    end
end
