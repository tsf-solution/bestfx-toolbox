function [pos] = portposition(phdl)
    % handle input arguments
    if nargin < 1
        phdl =  me.sl.creator.inspect.porthandle();
    end
    
    pos = get(phdl,'Position');
end