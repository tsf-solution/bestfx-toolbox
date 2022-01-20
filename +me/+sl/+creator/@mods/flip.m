function [bhdl,btyp] = flip(varargin)

% import third parties
import me.sl.utils.toHandle
import me.sl.creator.inspect.blocktype

% Gather options from user inputs
opts = processInputs(varargin{:});

% determine block to flip
xblk = [getfullname(opts.blockhandle) '/' opts.blockname];
bhdl = toHandle(xblk);
btyp = blocktype(bhdl);
% validate block vs flip settings
validatestring(btyp,{opts.onblocktype,opts.offblocktype});

% evaluate mask parameter
if strcmp(opts.maskparameter,'on')
    ntyp = opts.onblocktype;
else
    ntyp = opts.offblocktype;
end

% update block attributes
if not(isequal(btyp, ntyp))
    xblk = char(replace_block(opts.blockhandle,'FollowLinks','on','SearchDepth',1,'Name',opts.blockname,ntyp,'noprompt'));
    bhdl = toHandle(xblk);
    btyp = blocktype(bhdl);
end


%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.addParameter('blockhandle',gcbh,@(x)ishandle(x));
    IP.addParameter('blockname','Out',@(x)ischar(x));
    IP.addParameter('maskparameter','OutSinkPort',@(x)ischar(x));
    IP.addParameter('onblocktype','Outport',@(x)ischar(x));
    IP.addParameter('offblocktype','Terminator',@(x)ischar(x));
    IP.parse(varargin{:});
    options = IP.Results;
    
    options.maskparameter = validatestring(options.maskparameter,{'on','off'});
end
end
