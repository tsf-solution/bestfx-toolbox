function [bhdl] = blockhandle(str)
    % handle input arguments
    if nargin < 1
        str = gcb;
    end
    
    bhdl = getSimulinkBlockHandle(str);
    
    if ~ishandle(bhdl)
        error("Expected input to be alphanumeric simulink block path:\n\tblock '%s' does not exist!",str);
    end
end