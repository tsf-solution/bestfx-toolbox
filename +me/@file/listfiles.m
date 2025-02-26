function [list] = listfiles(rootpath,varargin)
% LISTFILES get recursive file tree
%
%      !rootpath!          - ...
%
%      'recurse'           - When true (default) will recursively find
%                          files in root_path.
%
%      'filePattern'       - String or cell array of strings of filenames
%                          to find. Regular expression syntax is used.
%
%      'dirPattern'        - String or cell array of strings of dirnames
%                          to find. Regular expression syntax is used.
%
%      'ignoreDirs'        - String or cell array of strings of dirnames
%                          to ignore. Regular expression syntax is used.
%
%      'ignoreSVN'         - Additional true/false option to ignore ".svn"
%                          directories. Defaults to TRUE for convenience.
%
%      'ignoreGIT'         - Additional true/false option to ignore ".git"
%                          directories. Defaults to TRUE for convenience.
%
%      'ignoreSimulink'    - Additional true/false option to ignore simulink
%                          directories like "slprj". Equivalent to adding
%                          {'^\.git$'} to "ignoreStrings". Defaults to TRUE
%                          for convenience.
%
% See also:
%    me.file.listdirs
%

%% PREPROCESSING

% import third parties
import me.file.listdirs

% Default values for required input arguments
if nargin < 1
    rootpath = pwd;
end

% Gather options from user inputs
opts = processInputs(varargin{:});


%% EXECUTE
dirlist = listdirs(rootpath,...
    'recurse',opts.recurse,...
    'searchPattern',opts.dirPattern,...
    'ignoreStrings',opts.ignoreDirs,...
    'ignoreSVN',opts.ignoreSVN,...
    'ignoreGIT',opts.ignoreGIT,...
    'ignoreSimulink',opts.ignoreSimulink...
    );

list = {};

for i=1:numel(dirlist)

    crntFiles = dir(char(dirlist(i)));

    for  k=1:numel(crntFiles)

        if ~crntFiles(k).isdir

            crntName = crntFiles(k).name;

            if ~isempty(opts.filePattern)
                match = regexp(crntName, opts.filePattern);
                if cellfun('isempty', match)
                    continue;
                end
            end
            list = [list;{[char(dirlist(i)),filesep,crntName]}];
        end
    end
end

%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = true;
    IP.addParameter('recurse',true,@(x)me.types.bool.validate(x));
    IP.addParameter('filePattern',{},@(x)iscellstr(x) || ischar(x))
    IP.addParameter('dirPattern',{},@(x)iscellstr(x) || ischar(x))
    IP.addParameter('ignoreSVN',true,@(x)me.types.bool.validate(x));
    IP.addParameter('ignoreGIT',true,@(x)me.types.bool.validate(x));
    IP.addParameter('ignoreSimulink',true,@(x)me.types.bool.validate(x));
    IP.addParameter('ignoreDirs',{},@(x)iscellstr(x) || ischar(x));
    IP.parse(varargin{:});
    options = IP.Results;

    % Generate a nice single "regexpString" from "filePattern" and "ignoreSVN"
    if ischar(options.filePattern)
        options.filePattern = {options.filePattern};
    end
end
end


