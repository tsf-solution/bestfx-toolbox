function [] = setmaskenable(prop,varargin)

% Required input arguments
narginchk(1,nargin);

% Gather options from user inputs
opts = processInputs(varargin{:});

%% EXECUTE
% find property in mask names
masknames = get(opts.blockhandle,'MaskNames');
TF = ismember(masknames,prop);
% update mask enables
maskenables = get(opts.blockhandle,'MaskEnables');
maskenables{TF} = opts.enable;
set(opts.blockhandle,'MaskEnables',maskenables);


%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.addParameter('blockhandle',gcbh,@(x)ishandle(x));
    IP.addParameter('enable','off',@(x)ischar(x));
    IP.parse(varargin{:});
    options = IP.Results;
    % validate strings
    options.enable = validatestring(options.enable,{'on','off'});
end
end