function relay(depth)

% import third parties
import me.sl.utils.findblocks
import me.sl.utils.autoname

% find blocks
bhdls = findblocks('Relay','depth',depth);

% Set foreground color
set( bhdls, 'ForegroundColor', 'black');
set( bhdls, 'BackgroundColor', 'white');
set( bhdls, 'ShowName', 'off');

% auto name: show name on/off
arrayfun(@(c)autoname(c),bhdls);

% attribute format string
chdls=num2cell(bhdls);
off = cellfun(@(c)get(c,'OffSwitchValue'),chdls,'UniformOutput',false);
on  = cellfun(@(c)get(c,'OnSwitchValue'),chdls,'UniformOutput',false);
cellfun(@(c,o1,o2)set(c,'AttributesFormatString',sprintf('[%s | %s]',o1,o2)),chdls,off,on);
end
