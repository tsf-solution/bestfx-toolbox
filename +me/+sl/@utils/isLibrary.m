function [tf] = isLibrary(bdhdl)
    if nargin<1
        bdhdl = bdroot;
    end
    bdhdl = me.sl.utils.toHandle(bdhdl);
    tf = strcmpi(get(bdhdl,'BlockDiagramType'),'library');
end