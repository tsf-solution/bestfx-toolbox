function [lhdl] = linehandle(phdl)
    % handle input arguments
    if nargin < 1
        phdl =  me.sl.creator.inspect.porthandle(gcbh,'type','Inport');
    end
    
    lineHandles = arrayfun(@(c)get(c,'Line'),phdl);
    lhdl = lineHandles(:);
end