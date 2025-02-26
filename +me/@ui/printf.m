function count = printf(varargin)
% PRINTF displays styled formatted text in the Command Window
%
% See also:
%    me.shared.cprintf.cprintf

%% PREPROCESSING

% import third parties
import me.shared.cprintf.cprintf
import me.utils.rgbcolor

% Default values for required input arguments
if nargin < 1
    demo();
    return;
end


if ischar(varargin{1})
    if ~ismember(varargin{1},{'comment'})
        varargin{1}=rgbcolor(varargin{1});
    end
end

%% EXECUTE
try 
    % execute third party
    count = cprintf(varargin{:});
catch ME
    rethrow(ME);
end
end

%% DEMO
function demo

    mpath = "me.ui";
    msep=".";
    mname = "printf";
    mfile = strcat(mpath,msep,mname);
    
    evalin('base','clc');
    
    % description and help link
    syntax="count = printf(style,format,...);";
    help=strcat("<a href=""matlab:clc;help ",mfile,""">here</a>");
    fprintf('Syntax: %s click %s for details.\n\n',syntax,help);

    % comment
    text=strcat(mfile,"('comment','this is a comment\n');");
    fstr = me.string.replacemarks(text,'apostrophes',"''");
    fprintf('>>> Demo <<< example command:\n%s\n',fstr);
    eval(fstr);
    % underlined mangenta
    text=strcat(mfile,"(-[1,0,1], 'underlined magenta\n');");
    fstr = me.string.replacemarks(text,'apostrophes',"''");
    fprintf('>>> Demo <<< example command:\n%s\n',fstr);
    eval(fstr);
    % orange text
    text=strcat(mfile,"('o', 'and multi-\nline orange\n');");
    fstr = me.string.replacemarks(text,'apostrophes',"''");
    fprintf('>>> Demo <<< example command:\n%s\n',fstr);
    eval(fstr);
end
