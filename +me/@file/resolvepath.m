function [opath] = resolvepath(ipath,varargin)
% RESOLVEPATH resolve relative path to absolute path
%
%      'attribute'         - path atribute which should be get. Valid
%                          attributes are:
%                           * abspath
%                           * relpath
%

%% PREPROCESSING

% import third parties
import me.string.textline

% show title line if standalone
if isequal(numel(dbstack),1)
    textline(mfilename);
end

% Gather options from input arguments
opts = processInputs(varargin{:});

% Default values for required input arguments
if nargin < 1
    if opts.debug
        ipath = {
            pwd
            [pwd '/test/../cfg']
            '../../../boa'
            '../../../boa/test.xls'
            'C:\'
            './'
            '\\server-01\data\meas_'
            'D:\data\meas_'
            };
    else
        ipath = pwd;
    end
end


%% EXECUTE
% handle cell arrays
if isa(ipath, 'cell')
    opath = cellfun(@(c)me.file.resolvepath(c,varargin{:}),ipath,'UniformOutput',false);
    return;
end

%% transfer to absolute path

% replace both type of slashes with os file seperator
ipath = regexprep(ipath,{'\\','\/'},{filesep,filesep});
% get type of path
isHarddiskPath = ~isempty(regexpi(ipath,'^[\w]{1}\:','match'));
isNetworkPath = startsWith(ipath,repmat(filesep,1,2));

% remove (other) double file seperators
ipath = regexprep(ipath,{repmat(['\' filesep],1,2)},{filesep});
% remove leading single point
ipath = regexprep(ipath,{'^[\.]?([^\.])'},{'$1'});
% split path at file seperator
partpath = regexpi(ipath,['\' filesep],'split');
% remove single points
partpath = regexprep(partpath,{'^\.$'},{''});

% get amount of path parts
n = numel(partpath);

% resolve root path
if isHarddiskPath
    newpath = partpath{1};
    partpath{1} = [];
elseif isNetworkPath
    newpath = [filesep filesep partpath{1}];
    partpath{1} = [];
else
    newpath = pwd;
end

% resolve path
for idx=1:n
    part = partpath{idx};
    if isequal(part,'..')
        newpath = fileparts(newpath);
    else
        newpath = fullfile(newpath,part);
    end
end

if endsWith(ipath,filesep)
    newpath = [newpath filesep];
end

opath = newpath;

%% transfer to relative path
if ismember(opts.attribute,'relpath')

    newpath = filesep;

    % use absolute path if different root path
    if ~isequal(regexpi(pwd,'^[\w]{1}\:','match'),regexpi(opath,'^[\w]{1}\:','match'))
        newpath = opath;
    % otherwise determine relative path
    else
        % split path at file seperator
        partpath = regexpi(pwd,filesep,'split');

        % get amount of path parts
        n = numel(partpath);

        % looking for the smallest common path
        for idx=n:-1:1
            part = fullfile(partpath{1:idx});
            if startsWith(opath,part)
                % construct relative path
                restpath = strrep(opath,part,'');
                newpath  = fullfile('',newpath,restpath);
                break;
            else
                newpath = fullfile(newpath,'..');
            end
        end
        % remove double file seperators
        newpath = regexprep(newpath,{repmat(['\' filesep],1,2)},{filesep});
    end

    opath = newpath;
end

%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function

    validattributes = {'abspath','relpath'};

    IP = inputParser;
    IP.KeepUnmatched = true;
    IP.addParameter('debug',false,@(x)me.types.bool.validate(x));
    IP.addParameter('attribute',validattributes{1},@(x)ischar(x));
    IP.parse(varargin{:});
    options = IP.Results;

    options.hook = validatestring(options.attribute,validattributes);
end
end
