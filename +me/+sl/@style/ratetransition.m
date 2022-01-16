function ratetransition(depth)

% import third parties
import me.sl.utils.findblocks
import me.sl.utils.autoname

% find blocks
bhdls = findblocks('RateTransition','depth',depth);

% Set foreground color
set( bhdls, 'ForegroundColor', 'black');
set( bhdls, 'BackgroundColor', 'white');
set( bhdls, 'ShowName', 'off');

% auto name: show name on/off
arrayfun(@(c)autoname(c,'^Rate Transition'),bhdls);

end

