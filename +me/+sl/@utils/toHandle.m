function [hdl] = toHandle(str)
    if ishandle(str)
        hdl = str;
    else
        hdl = get_param(str,'Handle');
    end
end