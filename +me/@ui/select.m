function [selection] = select(list, varargin)
% SELECT list elements for selection
%
%      !list!              - ...
%
%      'type'              - ...
%
%      'title'             - String which is displayed before the list is
%                          enumerated with indexer.
%      'prompt'            - ...
%
%      'indexer'           - ...
%
%      'indexerExit'       - ...
%
%      'showExit'          - ...
%
%      'trimItem'          - ...
%
%      'newline'           - ...
%

%% PREPROCESSING

% Cross-functional variables
vtyps = {'ListEntry', 'Number', 'Index'};

% Required input arguments, otherwise demo
if nargin < 1
    [list, varargin] = demo();
end

% count list entries
n = numel(list);

% Gather opts from user inputs
opts = processInputs(varargin{:});

%% EXECUTE
if n < 1
    warning("Sorry, there are no item entries in the list for displaying a selection menu!");
    selection = '';
    return;
end

% selection process
if n < 2 % one element in list
    num = 1;
else % more than one element in list
    itemlist = cellfun(@(c)trim(c), list, 'UniformOutput', false);

    msgs = strjoin(cellfun(@(i, l)sprintf('%6s %s\n', sprintf('[%s]', i), l), opts.indexer, itemlist, 'UniformOutput', false), '');

    if opts.showExit
        msgs = sprintf('%s%6s Exit\n', msgs, sprintf('[%s]', opts.indexerExit));
    end

    % string input
    msgs = sprintf('%s\n%s%s', opts.title, msgs, opts.prompt);
    indexer = input(msgs, 's');

    % find item id in list
    num = find(strcmpi(opts.indexer, indexer));
end

% valid, exit or invalid selection
if num <= n
    % valid selection
    if isequal(opts.type, 'Number')
        % return number of list entry
        selection = num;
    elseif isequal(opts.type, 'Index')
        % return index of list entry
        selection = opts.indexer{num};
    else
        % return list entry
        selection = list{num};
    end

elseif opts.showExit && (strcmpi(indexer, opts.indexerExit) || strcmpi(indexer, 'exit'))
    % exit an return empty string
    selection = '';
    return;
else
    % recursive function call for invalid selection
    warning("Sorry '%s' is no valid item index! Try again or type 'exit' to leave!", indexer);
    selection = me.ui.select(list, varargin{:});
end

%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = true;
    IP.addParameter('type', vtyps{1}, @(x)ischar(x));
    IP.addParameter('title', 'Please select a list item by index:', @(x)me.types.char.validatescalartext(x));
    IP.addParameter('prompt', 'Please enter selection: ', @(x)me.types.char.validatescalartext(x));
    IP.addParameter('indexer', strsplit(num2str([1:n])), @(x)validateattributes(x, {'cell'}, {'vector'}));
    IP.addParameter('indexerExit', num2str(n + 1), @(x)me.types.char.validatescalartext(x));
    IP.addParameter('showExit', true, @(x)me.types.bool.validate(x));
    IP.addParameter('trimItem', false, @(x)me.types.bool.validate(x));
    IP.addParameter('newline', me.types.char.unicode('hookleftarrow'), @(x)me.types.char.validatescalartext(x));

    IP.parse(varargin{:});
    options = IP.Results;

    options.type = validatestring(options.type, vtyps);
end

function entry = trim(entry)
    entry = me.string.replacemarks(entry, 'newline', opts.newline);

    if opts.trimItem
        [~, fname, fext] = fileparts(entry);
        entry = [fname, fext];
    end
end

end

%% DEMO
function [list, args] = demo()

    mpath = "me.ui";
    msep = ".";
    mname = "select";
    mfile = strcat(mpath, msep, mname);

    evalin('base', 'clc');

    % description and help link
    syntax = "[selection] = select(list, <key>, <value>, ...);";
    help = strcat(" < a href = ""matlab:clc; help ", mfile, """ > here </ a > ");
    fprintf('Syntax: %s click %s for details.\n\n', syntax, help);

    % live demo
    fprintf('>>> Live demo <<<:\n\n');
    list = [{'demo entry 1'}, {['demo entry' newline '2']}];
    args = {};
end
