function [str] = blockfullpath(bhdl)

    % handle input arguments
    if nargin < 1
        bhdl = gcbh;
    end
    
    str = getfullname(bhdl);
end