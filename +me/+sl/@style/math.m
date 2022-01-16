function math(depth)

% import third parties
import me.sl.utils.findblocks
import me.sl.utils.autoname
import me.sl.utils.filterblocktype
import me.sl.utils.filteriop

% find blocks
bhdls = findblocks('Abs|Add|Sum|Divide|Gain|Bias|Math|MinMax|Min|Max|Product|Trigonometry|sin|cos|tan|atan|Sign|Sqrt|Subtract|Sum|Width','depth',depth,'regexp','on');

% Set foreground color
set( bhdls, 'ForegroundColor', 'black');
set( bhdls, 'BackgroundColor', 'white');
set( bhdls, 'ShowName', 'off');
set( bhdls, 'AttributesFormatString', '');

% auto name: show name on/off
TF = arrayfun(@(x)filterblocktype(x,'Gain'),bhdls);
arrayfun(@(x)autoname(x,'Gain'),bhdls(TF));
TF = arrayfun(@(x)filterblocktype(x,'Bias'),bhdls);
arrayfun(@(x)autoname(x,'Bias'),bhdls(TF));

% iop on? (SaturateOnIntegerOverflow)
TF = arrayfun(@(c)filteriop(c),bhdls);
arrayfun(@(x) set(x,'AttributesFormatString','IOP: on'), bhdls(TF));

end

