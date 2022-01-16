function ratelimiter(depth)

% import third parties
import me.sl.utils.findblocks
import me.sl.utils.autoname

% find blocks
bhdls = findblocks('RateLimiter','depth',depth);

% Set foreground color
set( bhdls, 'ForegroundColor', 'black');
set( bhdls, 'BackgroundColor', 'white');
set( bhdls, 'ShowName', 'off');

% auto name: show name on/off
arrayfun(@(c)autoname(c,'^Rate Limiter'),bhdls);

% attribute format string
chdls=num2cell(bhdls);
rise = cellfun(@(c)get(c,'RisingSlewLimit'),chdls,'UniformOutput',false);
fall = cellfun(@(c)get(c,'FallingSlewLimit'),chdls,'UniformOutput',false);
cellfun(@(c,r,f)set(c,'AttributesFormatString',sprintf('[%s | %s]',r,f)),chdls,rise,fall);
end
