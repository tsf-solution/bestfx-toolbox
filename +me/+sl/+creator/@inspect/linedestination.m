function [bhdl] = linedestination(lhdl)
    % handle input arguments
    if nargin < 1
        phdl =  me.sl.creator.inspect.porthandle(gcbh,'type','Outport');
        lhdl =  me.sl.creator.inspect.linehandle(phdl);
    end
    
    bhdl = arrayfun(@(c)get(c,'DstBlockHandle'),lhdl,'UniformOutput',true);
end
