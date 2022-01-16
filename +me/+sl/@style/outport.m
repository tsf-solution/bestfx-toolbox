function outport(depth)

% import third parties
import me.sl.utils.findblocks
import me.sl.utils.toHandle

% find blocks
bhdls = findblocks('Outport','depth',depth);

% Set foreground color
set( bhdls, 'ForegroundColor', 'blue');
set( bhdls, 'BackgroundColor', 'white');

% attribute format string
arrayfun(@(x)setafs(x),bhdls);
end

function setafs(bhdl)

    % import third parties
    import me.sl.utils.toHandle
    import me.sl.utils.findblocks

    % identify parent system
    shdl = toHandle(get(bhdl,'Parent'));
    ehdl = findblocks('^(EnablePort|TriggerPort|ActionPort)$','shdl',shdl,'regexp','on','depth',1);
    
    afstr = '';
    
     % check parent system
    if isequal(numel(ehdl),1)
        % check outport
        if filteroutputreset(bhdl)
            % display reset attributes
            afstr = sprintf('%sOutputWhenDisabled: %%<OutputWhenDisabled> \n InitialOutput: %%<InitialOutput>',afstr);
        else
            % display hold attributes
            afstr = sprintf('%sOutputWhenDisabled: %%<OutputWhenDisabled>',afstr);
        end
    end
    
    set(bhdl,'AttributesFormatString',afstr);
end

function tf = filteroutputreset(bhdl)
    % get attribute state
    tf = isequal(regexp(get(bhdl,'OutputWhenDisabled'),'reset'),1);
end
