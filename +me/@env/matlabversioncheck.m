function tf = matlabversioncheck(str,varargin)
% MATLABVERSIONCHECK checks MATLAB version if it matches against the
% current MATLAB version
%
%      'comperator'        - Choose between the strings '==' (default),
%                          '<=', '<', '>=', '>' or '~='.
%
% See also:
%    me.env.matlabversion
%

%% PREPROCESSING

% import third parties
import me.env.matlabversion

% Default values for required input arguments
if nargin < 1
    demo();
    return;
end

% Gather options from user inputs
options = processInputs(varargin{:});


%% EXECUTE
% seeking for a passing label
match = char(regexp(str,'[\d]{4}[\w]{1}','match'));
% choose release a if alphabetic index is missing
if isempty(match)
    match = [char(regexp(str,'[\d]{4}','match')) 'a'];
end

% convert
rnum = vstr2vnum(match);
tnum = vstr2vnum(matlabversion('format','release'));

if eval(['rnum' options.comperator 'tnum'])
    tf = true;
else
    tf = false;
end


%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = true;
    try % 'addParameter', introduced in R2013b
        IP.addParameter('comperator','==',@(x)ischar(x))
    catch %'addParamValue', introduced in R2007a
        IP.addParamValue('comperator','==',@(x)ischar(x))
    end
    IP.parse(varargin{:});
    options = IP.Results;
end
end

%% LOCAL FUNCTION DEFINITIONS
function vnum = vstr2vnum(vstr)
    vstr = lower(vstr);
    % convert digits of year (YYYY) to number
    vnum = str2double(vstr(1:4)) * 1000;
    % convert alphabetic char index to ascii number
    vnum = vnum + vstr(5);
end

%% DEMO
function [str,args] = demo()
    mpath = "me.env";
    msep=".";
    mname = "matlabversioncheck";
    mfile = strcat(mpath,msep,mname);
    
    evalin('base','clc');
    
    % description and help link
    syntax="[tf] = matlabversioncheck(str, <key>, <value>, ...);";
    help=strcat("<a href=""matlab:clc;help ",mfile,""">here</a>");
    fprintf('Syntax: %s click %s for details.\n\n',syntax,help);
    
    ref = char(me.env.matlabversion('format','release'));
    me.ui.printf('comment','MATLAB version: %s\n\n',ref);
    % ==
    text=strcat(mfile,"('",ref,"');");
    fstr = me.string.replacemarks(text,'apostrophes',"''");
    fprintf('>>> Demo <<< example command:\n%s\n',fstr);
    tf = eval(fstr);
    fprintf('Result: %s\n\n',me.types.bool.toString(tf));
    % <
    text=strcat(mfile,"('",ref,"','comperator','<');");
    fstr = me.string.replacemarks(text,'apostrophes',"''");
    fprintf('>>> Demo <<< example command:\n%s\n',fstr);
    tf = eval(fstr);
    fprintf('Result: %s\n\n',me.types.bool.toString(tf));
    % >
    text=strcat(mfile,"('",ref,"','comperator','>');");
    fstr = me.string.replacemarks(text,'apostrophes',"''");
    fprintf('>>> Demo <<< example command:\n%s\n',fstr);
    tf = eval(fstr);
    fprintf('Result: %s\n\n',me.types.bool.toString(tf));
end
