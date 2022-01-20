function [str] = blockfullpath(bhdl)

    % import third parties
    import me.sl.creator.inspect.blockname
    import me.sl.creator.inspect.blockpath

    % handle input arguments
    if nargin < 1
        bhdl = gcbh;
    end
    
    str = sprintf('%s/%s',blockpath(bhdl),blockname(bhdl));
end