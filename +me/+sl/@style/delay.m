function delay(depth)

% import third parties
import me.sl.utils.findblocks
import me.sl.utils.filterblocktype

% find blocks
bhdls = findblocks('^(Delay|UnitDelay|Memory)$','depth',depth,'regexp','on');
bhdls = [bhdls;findblocks('(TransportDelay)$','depth',depth,'regexp','on')];

% Set foreground color
set( bhdls, 'ForegroundColor', 'cyan');
set( bhdls, 'BackgroundColor', 'white');
set( bhdls, 'ShowName', 'off');

% attribute format string
TF = arrayfun(@(x)filterblocktype(x,'^(Delay|UnitDelay|Memory)$'),bhdls);
arrayfun(@(x)setafs(x),bhdls(TF));
end

function setafs(bhdl)

    % import third parties
    import me.sl.utils.filtersampletime
    import me.sl.utils.filterinitialcondition

    afstr = '';
    
    if ~filtersampletime(bhdl)
        dt = get_param(bhdl,'SampleTime');
        afstr = sprintf('%sSampleTime: %s\n',afstr,dt);
    end
    
    if ~filterinitialcondition(bhdl)
        if filterinitialconditiondialog(bhdl)
            ic = get_param(bhdl,'InitialCondition');
            afstr = sprintf('%sIC=%s\n',afstr,ic);
        end
    end
    set(bhdl,'AttributesFormatString',afstr);
end

function tf = filterinitialconditiondialog(bhdl)
    % check if attribute exists
    if ~isfield(set(bhdl),'InitialConditionSource')
        % default case is ic from dialog
        tf = true;return;
    end
    % get attribute state
    tf = isequal(regexp(get(bhdl,'InitialConditionSource'),'Dialog'), 1);
end
