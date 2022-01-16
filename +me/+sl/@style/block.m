function block(depth)

% import third parties
import me.sl.utils.findblocks

% find blocks
bhdls = findblocks('block','attr','Type','depth',depth);

% Set foreground color
set( bhdls, 'ForegroundColor', 'black');

end

