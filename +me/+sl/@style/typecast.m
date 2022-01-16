function typecast(depth)

% import third parties
import me.sl.utils.findblocks
import me.sl.utils.autoname

% find blocks
bhdls = findblocks('DataTypeConversion','depth',depth);

% Set foreground color
set( bhdls, 'ForegroundColor', 'black');
set( bhdls, 'BackgroundColor', 'white');
set( bhdls, 'ShowName', 'off');

% auto name: show name on/off
arrayfun(@(c)autoname(c,'^Data Type Conversion'),bhdls);

end

