function [str] = textline(title, varargin)
% TEXTLINE returns or displays a line with a constant length
% including a customized title.
%
%      !title!              - String for the line title.
%
%      'length'             - Numeric integer to define constant length of
%                           textline. Default is 60 chars.
%
%      'titlealignment'     - String 'left' or 'right'
%
%      'linechar'           - One or more characters that represent the
%                           base of the line. Default is '-'.
%
%      'linecharpost'       - If empty identical with <linechar> option.
%                           One or more characters that represent the end
%                           of the line.
%
%      'titlespacechar'     - one or more characters which can serve as a
%                           placeholder between text and line. Default is
%                           empty char.
%
%      'titlespacecharpost' - If empty identical with <titlespacechar>
%                           option. One or more characters that represent
%                           which can serve as a placeholder after text
%                           and line.

%% PREPROCESSING

% Default values for required input arguments
if nargin < 1
    ST = dbstack(1);
    if ~isempty(ST)
        title = ST(1).name;
    else
        title = mfilename;
    end
end

% Gather options from user inputs
opts = processInputs(varargin{:});


%% EXECUTE

% build title
title = sprintf('%s%s%s',opts.titlespacechar,title,opts.titlespacecharpost);

% get length of title
lenghtOfTitle = length(title);
% get length to fill with line char
lenghtRest = opts.length - lenghtOfTitle;

% get length of linechars
sizepre  = numel(opts.linechar);
sizepost = numel(opts.linecharpost);

% handle text alignment
if strcmp(opts.titlealignment,'left')
    npre  = 3;
    npost = lenghtRest - npre;
else
    npost = 3;
    npre  = lenghtRest - npost;
end

% handle pre linechar if more than one character
if sizepre > 1
    nprerest  = mod(npre,sizepre);
    npre  = floor( npre / sizepre);
end
% handle post linechar if more than one character
if sizepost > 1
    npostrest = mod(npost,sizepost);
    npost = floor( npost / sizepost);
end

% combine linechars to strings
strpre  = strcat(repmat(opts.linechar,1,npre));
strpost = strcat(repmat(opts.linecharpost,1,npost));

% add single pre linechar if necessary
if sizepre > 1 && nprerest > 0
    strpre  = [strpre opts.linechar(1:nprerest)];
end
% add single post linechar if necessary
if sizepost > 1 && npostrest > 0
    strpost  = [strpost opts.linecharpost(1:npostrest)];
    opts.linecharpost
end

% combine to textline
strlong = sprintf('%s%s%s',strpre,title,strpost);

% return or disp textline, shortened if necessary.
if nargout == 1
    str = strlong(1:opts.length);
else
    strdisp = strlong(1:opts.length);
    if opts.debug
        fprintf('%s (numel: %d)\n',strdisp,numel(strdisp));
    else
        fprintf('%s\n',strdisp);
    end
end


%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function

    IP = inputParser;
    IP.KeepUnmatched = true;
    IP.addParameter('debug',false,@(x)me.types.bool.validate(x));
    IP.addParameter('linechar','-',@(x)me.types.char.validatescalartext(x));
    IP.addParameter('linecharpost','',@(x)me.types.char.validatescalartext(x));
    IP.addParameter('titlespacechar','',@(x)me.types.char.validatescalartext(x));
    IP.addParameter('titlespacecharpost','',@(x)me.types.char.validatescalartext(x));
    IP.addParameter('titlealignment','right',@(x)ischar(x));
    IP.addParameter('length',60,@(x)me.types.integer.validateNonNegative(x));
    IP.parse(varargin{:});
    options = IP.Results;

    % validate alignment
    options.titlealignment = validatestring(options.titlealignment,{'right','left'});

    % adopt linechar to linecharpost
    if isempty(options.linecharpost)
        options.linecharpost = options.linechar;
    end

    % adopt titlespacechar to titlespacecharpost
    if isempty(options.titlespacecharpost)
        options.titlespacecharpost = options.titlespacechar;
    end
end
end


