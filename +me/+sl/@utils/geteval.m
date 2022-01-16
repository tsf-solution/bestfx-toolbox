function [str] = geteval(bhdl,key)
    str = get(bhdl,key);
    try
        str = mat2str(evalin('base',str));
    catch
        % do nothing
    end
end