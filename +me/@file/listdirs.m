function [list] = listdirs(varargin)
% LISTDIRS get recursive dir tree
%
%      'pathname'          - ...
%
%      'recurse'           - When true (default) will recursively find
%                          dirs in root_path.
%
%      'searchPattern'     - String or cell array of strings of dirnames
%                          to find. Regular expression syntax is used.
%
%      'ignoreStrings'     - String or cell array of strings of dirnames
%                          to ignore. Regular expression syntax is used.
%
%      'ignoreSVN'         - Additional true/false option to ignore ".svn"
%                          directories. Equivalent to adding {'^\.svn$'}
%                          to "ignoreStrings". Defaults to TRUE for
%                          convenience.
%
%      'ignoreGIT'         - Additional true/false option to ignore ".git"
%                          directories. Equivalent to adding {'^\.git$'}
%                          to "ignoreStrings". Defaults to TRUE for
%                          convenience.
%
%      'ignoreSimulink'    - Additional true/false option to ignore simulink
%                          directories like "slprj". Equivalent to adding
%                          {'^\.git$'} to "ignoreStrings". Defaults to TRUE
%                          for convenience.
%
% See also:
%    dir

%% PREPROCESSING

% Default values for required input arguments
if mod(nargin, 2) % odd
    varargin = [{'pathname'}, varargin];
end

% Gather options from user inputs
opts = processInputs(varargin{:});

%% EXECUTE
listing = dir(opts.pathname);
% ignore files
listing = listing([listing.isdir]);

% start with empty list
list = {};
% interate through listing (recursive)
for idx = 1:numel(listing)
    C = extendNotIgnoredToList(listing(idx));
    list = [list; C];
end

% add start pathname to list
list = [{opts.pathname}; list];

% search pattern in list or remove from list
list = removeNotMatchedFromList(list);

%% search pattern
function C = removeNotMatchedFromList(C)

    if ~isempty(opts.searchPattern)
        RSLT = arrayfun(@(c)regexp(c, opts.searchPattern), C, 'UniformOutput', false);
        TF = cellfun(@(c)logical(sum([c{:}])), RSLT, 'UniformOutput', true);
        C = C(TF);
    end

end

%% ignore dirs
function C = extendNotIgnoredToList(S)
    pathname = [S.folder filesep S.name];

    if isempty(cell2mat(regexp(S.name, opts.ignoreStrings)))

        if opts.recurse
            C = me.file.listdirs(varargin{:}, 'pathname', pathname);
        else
            C = {pathname};
        end

    else
        C = [];
    end

end

%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = true;
    IP.addParameter('pathname', pwd, @(x)exist(x, 'dir'));
    IP.addParameter('recurse', true, @(x)me.types.bool.validate(x));
    IP.addParameter('searchPattern', {}, @(x)iscellstr(x) || ischar(x));
    IP.addParameter('ignoreStrings', {}, @(x)iscellstr(x) || ischar(x));
    IP.addParameter('ignoreSVN', true, @(x)me.types.bool.validate(x));
    IP.addParameter('ignoreGIT', true, @(x)me.types.bool.validate(x));
    IP.addParameter('ignoreSimulink', true, @(x)me.types.bool.validate(x));
    IP.parse(varargin{:});
    options = IP.Results;

    % Generate a nice single "excludeRegexpString" from "ignoreStrings"
    if ischar(options.ignoreStrings)
        options.ignoreStrings = {options.ignoreStrings};
    end

    options.ignoreStrings{end + 1} = '\.$';
    options.ignoreStrings{end + 1} = '\.\.$';

    % Exclude '.svn' directories if requested.
    if options.ignoreSVN
        options.ignoreStrings{end + 1} = '^\.svn$';
    end

    % Exclude '.git' directories if requested.
    if options.ignoreGIT
        options.ignoreStrings{end + 1} = '^\.git$';
    end

    % Exclude 'slprj' directories if requested.
    if options.ignoreSimulink
        options.ignoreStrings{end + 1} = '^slprj$';
    end

end
end
