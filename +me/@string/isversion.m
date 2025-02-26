function [tf] = isversion(str,varargin)
% ISVERSION return true for numeric version strings
%
%      !ver!               - ...
%
%      'separator'         - Char to separate version parts '.' (default)
%

%% PREPROCESSING

% Default values for required input arguments
if nargin < 1
    [str,varargin] = demo();
end

% Gather options from user inputs
options = processInputs(varargin{:});


%% EXECUTE
% modify separator to use it in regular expression
if sum(strcmp(options.separator,{'.','\','/'}))
    sep =  ['\' options.separator];
else
    sep = options.separator;
end

% remove optional leading char v of version string
vstr = regexprep(str,'^[vV]{1}','');
% split version string in numeric parts
vstr = regexp(vstr,sep,'split');
vnum = str2double(vstr);

if sum(isnan(vnum))
    tf = false;
%         error('Expected input to be a version string')
else
    tf = true;
end


%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = true;
    IP.addParameter('separator','.',@(x)ischar(x))
    IP.parse(varargin{:});
    options = IP.Results;
end
end

%% DEMO
function [str,args] = demo()
    mpath = "me.string";
    msep=".";
    mname = "isversion";
    mfile = strcat(mpath,msep,mname);
    
    evalin('base','clc');
    
    % description and help link
    syntax="[tf] = isversion(str, <key>, <value>, ...);";
    help=strcat("<a href=""matlab:clc;help ",mfile,""">here</a>");
    fprintf('Syntax: %s click %s for details.\n\n',syntax,help);
    
    str = char('v1.0.0');
    fprintf('>>> Demo <<< example version string to check:\n%s\n',str);
    args = {};
end

