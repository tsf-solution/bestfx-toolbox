function [tf] = filteriop(bhdl)
    % check if attribute exists
    if ~isfield(set(bhdl),'SaturateOnIntegerOverflow')
        % default case is iop disabled
        tf = false;return;
    end
    % get attribute state
    tf = isequal(get(bhdl,'SaturateOnIntegerOverflow'),'on');
end