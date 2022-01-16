function constant(depth)

% import third parties
import me.sl.utils.findblocks
import me.sl.utils.autoname

% find blocks
bhdls = findblocks('Constant','depth',depth);

% Set foreground color
set( bhdls, 'ForegroundColor', 'black');
arrayfun(@(c)backgroundcolor(c),bhdls);
% set( bhdls, 'BackgroundColor', 'orange');
set( bhdls, 'ShowName', 'off');

% auto name: show name on/off
arrayfun(@(c)autoname(c),bhdls);
end

function backgroundcolor(bhdl)
    [~,ok] = str2num(get_param(bhdl,'Value'));
    if ok
        % color constants
        set_param(bhdl,'BackgroundColor','orange');
    else
        % color parameters
        set_param(bhdl,'BackgroundColor','lightblue');
    end

end
