function demux(depth)

% import third parties
import me.sl.utils.findblocks
import me.sl.utils.filterblocktype

% find blocks
bhdls = findblocks('Demux','depth',depth);

% Set foreground color
set( bhdls, 'ForegroundColor', 'black');
set( bhdls, 'BackgroundColor', 'white');
set( bhdls, 'ShowName', 'off');
end
