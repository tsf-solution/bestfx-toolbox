function [str] = blockpath(bhdl)
    % handle input arguments
    if nargin < 1
        bhdl = gcbh;
    end
    
    if isprop(bhdl,'path')
        str = get(bhdl,'path');
    end
end