function switches(depth)

% import third parties
import me.sl.utils.findblocks
import me.sl.utils.filterblocktype

% find blocks
bhdls = findblocks('Switch','depth',depth);
bhdls = [bhdls;findblocks('MultiPortSwitch','depth',depth)];

% Set foreground color
set( bhdls, 'ForegroundColor', 'black');
set( bhdls, 'BackgroundColor', 'white');
set( bhdls, 'ShowName', 'off');

% attribute format string
TF = arrayfun(@(x)filterblocktype(x,'^Switch$'),bhdls);
arrayfun(@(x)setafs(x),bhdls(TF));
end

function setafs(bhdl)
    if isequal(regexp(get( bhdl, 'Criteria'),'u2 ~= 0'), 1)
        set(bhdl, 'AttributesFormatString', '');
    else
        set(bhdl, 'AttributesFormatString', '%<Criteria> \n Threshold: %<Threshold>');
    end
end
