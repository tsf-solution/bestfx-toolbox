function [] = autoname(bhdl,re)
    if nargin < 2
        re = sprintf('^%s',get(bhdl,'BlockType'));
    end
    if not(isequal(regexp(get(bhdl,'Name'),re),1))
        set(bhdl,'ShowName','on');
    end
end