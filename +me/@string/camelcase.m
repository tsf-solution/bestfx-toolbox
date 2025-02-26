function [str] = camelcase(str,varargin)
% CAMELCASE convert string with separator to camel case notation
%
%      !str!               string scalar or character vector
%
%      'separator'         - specifies the word separators. Underscores
%                          are default. Regular expression syntax is used.
%
%      'reverse'           - sets the camelcase reversing function to
%                          get separated string

%% PREPROCESSING

% Default values for required input arguments
if nargin<1
    demo();
    return;
end

% Gather options from user inputs
opts = processInputs(varargin{:});


%% EXECUTE

if opts.reverse
    sstr = '([a-z0-9]+)([A-Z]{1})';
    rstr = ['$1' opts.separator '$2'];
else
    sstr = ['([' opts.separator ']+|^)([\w])'];
    rstr = '${upper($2)}';
end    
str = regexprep((str),sstr,rstr);


%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = true;
    IP.addParameter('separator','_',@(x)ischar(x))
    IP.addParameter('reverse',false,@(x)me.types.bool.validate(x));
    IP.parse(varargin{:});
    options = IP.Results;
end
end

%% DEMO
function demo()  % nested function

    mpath = "me.string";
    msep=".";
    mname = "camelcase";
    mfile = strcat(mpath,msep,mname);
    
    evalin('base','clc');
    
    % description and help link
    syntax="[str] = camelcase(str, <key>, <value>, ...);";
    help=strcat("<a href=""matlab:clc;help ",mfile,""">here</a>");
    fprintf('Syntax: %s click %s for details.\n\n',syntax,help);

    str = '_camelCase_deMo_tExt';
    fprintf('>>> Demo <<< example text to convert:\n\n');
    
    text=strcat(mfile,"('",str,"');");
    fstr = me.string.replacemarks(text,'apostrophes',"''");
    [~,str] = evalc(fstr);
    fprintf("\t'%s' = %s\n",str(:),fstr);
end
