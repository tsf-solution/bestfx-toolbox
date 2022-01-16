function [str] = toSystem(shdl)
    if ishandle(shdl)
        bpath = get(shdl,'Path');
        bname = get(shdl,'Name');
        if strcmpi(get(shdl,'Type'),'block_diagram')
            str = [bpath];
        else
            str = [bpath '/' bname];
        end
    else
        str = shdl;
    end
end