function [hdl] = progressbar(step,varargin)
% TEXTPRORESSBAR initializes a text progress bar for monitoring a
% task progress in the MATLAB command window
%
%      !step!              - ...
%
%      'startmsg'          - ...
%
%      'endmsg'            - ...
%
%      'barlength'         - ...
%
%      'update'            - ...
%
%      'showremtime'       - ...
%
%      'showfinaltime'     - ...
%
%      'showactualnum'     - ...
%
%      'barsymbol'         - ...
%
%      'emptybarsymbol'    - ...
%
% See also:
%    me.shared.textprogressbar.textprogressbar

%% PREPROCESSING

% import third parties
import me.shared.textprogressbar.textprogressbar

% Default values for required input arguments
if nargin < 1
    demo();
    return;
end

% Gather opts from user inputs
opts = processInputs(varargin{:});


%% EXECUTE
try
    hdl = textprogressbar(step,...
        'barlength', opts.barlength, ...
        'update', opts.update, ...
        'startmsg', opts.startmsg,...
        'endmsg', opts.endmsg, ...
        'showremtime', opts.showremtime, ...
        'showfinaltime', opts.showfinaltime, ...
        'showactualnum', opts.showactualnum, ...
        'barsymbol', opts.barsymbol, ...
        'emptybarsymbol', opts.emptybarsymbol);

catch ME
    throw(ME);
end

%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = true;
    IP.addParameter('barlength',15,@(x)validateattributes(x,{'numeric'},{'nonempty','integer','scalar','positive'}));
    IP.addParameter('update',2,@(x)validateattributes(x,{'numeric'},{'nonempty','integer','scalar','positive'}));
    IP.addParameter('startmsg','Waiting ... ',@(x)ischar(x));
    IP.addParameter('endmsg',' Done.',@(x)ischar(x));
    IP.addParameter('showremtime',false,@islogical);
    IP.addParameter('showbar',true,@islogical);
    IP.addParameter('showpercentage',true,@islogical);
    IP.addParameter('showactualnum',false,@islogical);
    IP.addParameter('showfinaltime',false,@islogical);
    IP.addParameter('barsymbol','+',@(x)ischar(x));
    IP.addParameter('emptybarsymbol',' ',@(x)ischar(x));
    IP.parse(varargin{:});
    options = IP.Results;
end
end



% Display the help and demo
function demo

    mpath = "me.ui";
    msep=".";
    mname = "progressbar";
    mfile = strcat(mpath,msep,mname);
    
    evalin('base','clc');
    
    % description and help link
    syntax=strcat("[fhdl] = ",mfile,"(step, <key>, <value>, ...);");
    help=strcat("<a href=""matlab:clc;help ",mfile,""">here</a>");
    fprintf('Syntax: %s click %s for details.\n\n',syntax,help);
    
    % demo, how to call
    fstr(1)=strcat("udpt = ",mfile,"(100);");
    fstr(2)=strcat("for i = 1:100,\n\tpause(0.01);\n\tupdt(i);\nend\n\n");   
    fprintf('>>> Demo <<< example how to call:\n\n%s\n',fstr(1));
    fprintf(fstr(2));

    % live demo
    fprintf('>>> Live demo <<<:\n\n');
    step = 100; % Number of items
    updt = me.ui.progressbar(step);

    for i = 1:step
        pause(0.01);
        updt(i);
    end
end
