function switchinteractive(varargin)

%% PREPROCESSING

% Gather options from user inputs
opts = processInputs(varargin{:});

%% EXECUTE

% get value of dialog parameters
flSwitch = get(opts.blockhandle,'ctrl');

switch(opts.clbk)
    case 'init'
        if strcmpi(flSwitch,'on')
            set(opts.blockhandle,'MaskDisplay','disp(''ON'')');
            set(opts.blockhandle,'BackgroundColor','green');
        else
            set(opts.blockhandle,'MaskDisplay','disp(''OFF'')');
            set(opts.blockhandle,'BackgroundColor','white');
        end
    case 'openfnc'
        if strcmpi(flSwitch,'on')
            set(opts.blockhandle,'ctrl','off');
        else
            set(opts.blockhandle,'ctrl','on');
        end        
end




%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = false;
    IP.addParameter('clbk','init',@(x)ischar(x));
    IP.addParameter('blockhandle',gcbh,@(x)ishandle(x));
    IP.parse(varargin{:});
    options = IP.Results;
    
    options.clbk = validatestring(options.clbk,{'init','openfnc'});
end
end
