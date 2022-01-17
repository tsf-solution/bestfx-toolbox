function [str] = blocktype(bhdl)
    % handle input arguments
    if nargin < 1
        bhdl = gcbh;
    end
    
    if isprop(bhdl,'BlockType')
        str = get(bhdl,'BlockType');
    end
end