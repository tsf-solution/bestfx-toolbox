function terminator(depth)

% import third parties
import me.sl.utils.findblocks

% find blocks
bhdls = findblocks('Ground|Terminator','depth',depth,'regexp','on');

% Set foreground color
set( bhdls, 'ForegroundColor', 'black');
set( bhdls, 'BackgroundColor', 'white');
set( bhdls, 'ShowName', 'off');

end

