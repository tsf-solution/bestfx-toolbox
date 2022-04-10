function [bhdl] = insert(blockname,varargin)

%% PREPROCESSING

% Default values for required input arguments
if nargin < 1
    blockname = [];
% recursive call for cell array
elseif iscell(blockname)
    bhdl = cellfun(@(c)me.sl.creator.mods.insert(c),blockname);
    return;
% recursive call for integer quantity
elseif isnumeric(blockname)
    me.types.integer.validatePositive(blockname);
    bhdl = arrayfun(@(a)me.sl.creator.mods.insert,[1:blockname]);
    return;
end

% Gather options from user inputs
opts = processInputs(varargin{:});

%% EXECUTE

loadLibrary(extractBefore(opts.libraryblock,'/'));

% determine system full path
sys = me.sl.utils.toSystem(opts.systemhandle);

% determine default block name
if isempty(blockname)
    k = find(opts.libraryblock == '/', 1, 'last');
    blockname = extractAfter(opts.libraryblock,k);
end

% insert unique block
bhdl = add_block(...
    opts.libraryblock,[sys '/' blockname],...
    'MakeNameUnique','on',...
    'Position',opts.position,...
    'Orientation',opts.orientation);


%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.addParameter('systemhandle',get_param(gcs,'Handle'),@(x)ishandle(x));
    IP.addParameter('libraryblock','built-in/Subsystem',@(x)ischar(x));
    IP.addParameter('position',[0 0 100 50],@(x)me.types.integer.validateVector(x,4));
    IP.addParameter('orientation','right',@(x)ischar(x));
    IP.parse(varargin{:});
    options = IP.Results;
    
    % validate orientation
    options.orientation = validatestring(options.orientation,{'right','down','left','up'});
end

function loadLibrary(libraryname)
    % get library name
    if ~contains(libraryname,'built-in')
        if ~bdIsLoaded(libraryname)
            bd = bdroot; % notice which model is top model
            load_system(libraryname); % load library
            load_system(bd); % restore noted top model
        end
    end
end
end
