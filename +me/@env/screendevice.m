function [CFG] = screendevice(varargin)
% SCREENDEVICE returns properties of screen devices
%
%      'name'              - screen device name which attributes should
%                          be get. Valid attributes are:
%                            * primary (default)
%                            * next
%                            * all
%
%      'index'             - Dominant argument, which returns screen device
%                          properties by screen device index.
% See also:
%    java, http://docs.oracle.com/javase/8/docs/api/java/awt/GraphicsEnvironment.html
%

%% PREPROCESSING

% Gather options from user inputs
opts = processInputs(varargin{:});

%% EXECUTE

% get graphic environment
genv = java.awt.GraphicsEnvironment.getLocalGraphicsEnvironment();

% get screen devices
gdev = genv.getScreenDevices();
glen = numel(gdev);

% Find primary
DFLT = default();

if isnan(opts.index)
    if ismember(opts.name,{'all'})
        % get devices configuration
        CFG = arrayfun(@(a)configuration(a),1:glen);
    elseif ismember(opts.name,{'next'})
        if DFLT.index < glen
            idx = DFLT.idx + 1;
        else
            idx = 1;
        end
        CFG = configuration(idx);
    else % primary
        CFG = configuration(DFLT.index);
    end
else
    CFG = configuration(opts.index);
end

%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = true;
    IP.addParameter('name','primary',@(x)ischar(x))
    IP.addParameter('index',NaN,@(x)validateattributes(x,{'numeric'},{'scalar','integer','positive'}))
    IP.parse(varargin{:});
    options = IP.Results;
    
    options.name = validatestring(options.name,{'all','primary','next'});
end

%% DEFAULT SCREEN DEVICE
function DFLT = default()  % nested function
    DFLT.label = 'Primary';
    try
        % default screen
        DFLT.index = genv.getDefaultScreenDevice().getScreen()+1;
    catch
        warning('  Unable to detect default screen! Screen with index ''1'' is used instead as default.');
        DFLT.index = 1;
    end
end

%% SCREEN DEVICE CONFIGURATION
function CFG = configuration(idx)  % nested function
    validateattributes(idx,{'numeric'},{'scalar','integer','positive','<=',glen});
    
    if DFLT.index==idx
        label = DFLT.label;
    else
        label = sprintf('Index %d',idx);
    end
    
    gc = gdev(idx).getConfigurations();
    gb = gc(1).getBounds();
    CFG.name  = label;
    CFG.index = idx;
    CFG.total = glen;
    CFG.x     = gb.getX();
    CFG.y     = gb.getY();
    CFG.w     = gb.getWidth();
    CFG.h     = gb.getHeight();
end
end
