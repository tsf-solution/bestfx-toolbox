function enable(depth)

% import third parties
import me.sl.utils.findblocks

% find blocks
bhdls = findblocks('^(EnablePort|TriggerPort|ActionPort)$','depth',depth,'regexp','on');

% Set foreground color
set( bhdls, 'ForegroundColor', 'black');
set( bhdls, 'BackgroundColor', 'white');
set( bhdls, 'ShowName', 'off');

% attribute format string
arrayfun(@(x)setafs(x),bhdls);
end

function setafs(bhdl)

    % import third parties
    import me.sl.utils.filterblocktype

    afstr = '';
    
    if filterblocktype(bhdl,'^ActionPort')
        afstr = sprintf('%sS: %%<InitializeStates>',afstr);
    else
        afstr = sprintf('%sS: %%<StatesWhenEnabling>',afstr);
    end
    
    set(bhdl,'AttributesFormatString',afstr);
end