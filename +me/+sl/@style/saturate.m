function saturate(depth)

% import third parties
import me.sl.utils.findblocks
import me.sl.utils.autoname

% find blocks
bhdls = findblocks('Saturate','depth',depth);

% Set foreground color
set( bhdls, 'ForegroundColor', 'black');
set( bhdls, 'BackgroundColor', 'white');
set( bhdls, 'ShowName', 'off');

% auto name: show name on/off
arrayfun(@(c)autoname(c,'^Saturation'),bhdls);

% attribute format string
chdls=num2cell(bhdls);
lwr = cellfun(@(c)get(c,'LowerLimit'),chdls,'UniformOutput',false);
upr  = cellfun(@(c)get(c,'UpperLimit'),chdls,'UniformOutput',false);
cellfun(@(c,l,u)set(c,'AttributesFormatString',sprintf('[%s .. %s]',l,u)),chdls,lwr,upr);
end

