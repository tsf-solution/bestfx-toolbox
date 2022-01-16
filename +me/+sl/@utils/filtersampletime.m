function [tf] = filtersampletime(bhdl)
    % check if attribute exists
    if ~isfield(set(bhdl),'SampleTime')
        % default case is inherit sample time
        tf = true;return;
    end
    % get attribute state
    tf = isequal(regexp(get(bhdl, 'SampleTime'),'^(-1)$'),1);
end