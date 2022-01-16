function inport(depth)

% import third parties
import me.sl.utils.findblocks

% find blocks
bhdls = findblocks('Inport','depth',depth);

% Set foreground color
set( bhdls, 'ForegroundColor', 'green');
set( bhdls, 'BackgroundColor', 'white');

% attribute format string
arrayfun(@(x)setafs(x),bhdls);
end

function setafs(bhdl)

    % import third parties
    import me.sl.utils.filteroutdatatypestr
    import me.sl.utils.filterportdimensions
    
    afstr = '';
    
    if ~filteroutdatatypestr(bhdl)
        afstr = sprintf('%sOutDataTypeStr: %%<OutDataTypeStr>\n',afstr);
    end
    
    if~filterportdimensions(bhdl)
        afstr = sprintf('%sPortDimensions: %%<PortDimensions>\n',afstr);
    end
    
    set(bhdl,'AttributesFormatString',afstr);
end

