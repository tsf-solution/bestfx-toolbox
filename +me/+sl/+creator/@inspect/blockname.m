function [str] = blockname(bhdl)
    % handle input arguments
    if nargin < 1
        bhdl = gcbh;
    end
    
    if isprop(bhdl,'name')
        str = get(bhdl,'Name');
    end
end