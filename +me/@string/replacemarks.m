function [text] = replacemarks(text,varargin)
% REPLACEMARKS replace special chars in string(s)
%
%      !text!              string scalar or character vector
%
%      'newline'           - alternative character which replace newline
%                          characters in a text
%
%      'colon'             - alternative character which replace colon
%                          characters in a text
%
%      'whitespace'        - alternative character which replace whitespace
%                          characters in a text
%
%      'apostrophe'        - alternative character which replace apostrophe
%                          characters in a text
%

%% PREPROCESSING

% Default values for required input arguments
if nargin < 1
    [text,varargin] = demo();
end

% Gather options from user inputs
opts = processInputs(varargin{:});

%% EXECUTE

% validate input text
me.types.char.validatescalartext(text);

% replace punctuation marks, typeset and special characters
text = regexprep(text,newline,opts.newline);
text = regexprep(text,":",opts.colon);
text = regexprep(text," ",opts.whitespace);
text = regexprep(text,"'",opts.apostrophe);


%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = true;
    IP.addParameter('newline',newline,@(x)me.types.char.validatescalartext(x));
    IP.addParameter('colon',":",@(x)me.types.char.validatescalartext(x));
    IP.addParameter('whitespace'," ",@(x)me.types.char.validatescalartext(x));
    IP.addParameter('apostrophe',"'",@(x)me.types.char.validatescalartext(x));
    IP.parse(varargin{:});
    options = IP.Results;

    options.newline=char(options.newline);
    options.colon=char(options.colon);
    options.whitespace=char(options.whitespace);
    options.apostrophe=char(options.apostrophe);
end
end


%% DEMO
function [text,args] = demo()
    mpath = "me.string";
    msep=".";
    mname = "replacemarks";
    mfile = strcat(mpath,msep,mname);

    evalin('base','clc');

    % description and help link
    syntax="[text] = replacemarks(text, <key>, <value>, ...);";
    help=strcat("<a href=""matlab:clc;help ",mfile,""">here</a>");
    fprintf('Syntax: %s click %s for details.\n\n',syntax,help);

    text=strcat("Demo Text with 'apostrophes', colon: and one newline between the next two x: x",newline,"x");
    fprintf('>>> Demo <<< example text to convert:\n%s',text);
    args = {'newline',"~",'whitespace','_','apostrophe','*'};
end


