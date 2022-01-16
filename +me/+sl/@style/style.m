classdef style
    
    properties (Constant)
        DEBUG = true;
    end
    
    methods(Static)
        function apply
            import me.sl.style
            depth = 1;
            style.model();
            style.block(depth);
            style.inport(depth);
            style.outport(depth);
            style.logic(depth);
            style.math(depth);
            style.terminator(depth);
            style.constant(depth);
        end
    end

    methods(Access=private, Static)
        model()
        block(depth)
        inport(depth)
        outport(depth)
        logic(depth)
        math(depth)
        terminator(depth)
        constant(depth)
    end
end
