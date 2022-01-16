function logic(depth)

% import third parties
import me.sl.utils.findblocks

% find blocks
bhdls = findblocks('Logic','depth',depth);
bhdls = [bhdls;findblocks('RelationalOperator','depth',depth)];
bhdls = [bhdls;findblocks('Compare[\s]+To[\s]+','depth',depth,'regexp','on','attr','ReferenceBlock')];

% Set foreground color
set( bhdls, 'ForegroundColor', 'magenta');
set( bhdls, 'BackgroundColor', 'white');
set( bhdls, 'ShowName', 'off');

end

