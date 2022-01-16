function [tf] = isLoaded(bdhdl)
    if nargin<1
        bdhdl = bdroot;
    end
    bd = me.sl.utils.toSystem(bdhdl);
    tf = ismember(bd,find_system('type','block_diagram'));
end