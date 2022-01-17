function [] = flipOutportTerminator(prop,blockname,varargin)

% import third parties
import me.sl.utils.toHandle
import me.sl.creator.mods.blocktype
import me.sl.creator.mods.ports

% Required input arguments
narginchk(2,nargin);

% Gather options from user inputs
opts = processInputs(varargin{:});

% check property which control flip
if isprop(opts.blockhandle,prop)
    propval = get(opts.blockhandle,prop);
    propval = validatestring(propval,{'on','off'});
end

% determine block to flip
xblk = [getfullname(opts.blockhandle) '/' blockname];
xhdl = toHandle(xblk);
xtyp = blocktype(xhdl);

if ~contains(xtyp,{'Outport','Terminator'})
    error("BlockType is not 'Outport' or 'Terminator'");
end

if strcmp(propval,'on'), ntyp = 'Outport'; else, ntyp = 'Terminator';end

% update block attributes
if not(isequal(xtyp, ntyp))
    xblk = char(replace_block(opts.blockhandle,'FollowLinks','on','SearchDepth',1,'Name',blockname,ntyp,'noprompt'));
    xhdl = toHandle(xblk);
    clear xtyp;
end

if isequal(ntyp, 'Outport')
    set(xhdl, 'ForegroundColor','blue');
    if isnumeric(opts.portposition)
        n = numel(ports('blockhandle',opts.blockhandle,'type','Outport'));
        opts.portposition = min(n,opts.portposition);
        set(xhdl, 'Port',num2str(opts.portposition));
    end
end

%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.addParameter('blockhandle',gcbh,@(x)ishandle(x));
    IP.addParameter('portposition','end',@(x)me.types.integer.validatePositive(x));
    IP.parse(varargin{:});
    options = IP.Results;
end
end