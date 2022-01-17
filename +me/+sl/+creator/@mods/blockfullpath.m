function [str] = blockfullpath(bhdl)

    % import third parties
    import me.sl.creator.mods.blockname
    import me.sl.creator.mods.blockpath

    % handle input arguments
    if nargin < 1
        bhdl = gcbh;
    end
    
    str = sprintf('%s/%s',blockpath(bhdl),blockname(bhdl));
end