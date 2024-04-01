function [bhdl] = linesource(lhdl)
    % handle input arguments
    if nargin < 1
        phdl =  me.sl.creator.inspect.porthandle(gcbh,'type','Inport');
        lhdl =  me.sl.creator.inspect.linehandle(phdl);
    end
    
    bhdl = arrayfun(@(c)get(c,'SrcBlockHandle'),lhdl,'UniformOutput',true);
end
