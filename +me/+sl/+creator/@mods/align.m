function [] = align(varargin)

%% PREPROCESSING

% import third parties
import me.sl.creator.inspect.porthandle

% Cross-functional variables
vmthd = {'All','Inport','Outport'};

% Gather options from user inputs
opts = processInputs(varargin{:});

%% EXECUTE

% align inports
if ismember(opts.method,{'All','Inport'})
    phdls = porthandle(opts.blockhandle,'type','Inport');
    arrayfun(@(c)alignInport(c),phdls);
end

% align outports
if ismember(opts.method,{'All','Outport'})
    phdls = porthandle(opts.blockhandle,'type','Outport');
    arrayfun(@(c)alignOutport(c),phdls);
end

%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.addParameter('debug',false,@(x)me.types.bool.validate(x));
    IP.addParameter('blockhandle',gcbh,@(x)ishandle(x));
    IP.addParameter('method',vmthd{1},@(x)ischar(x));
    IP.parse(varargin{:});
    options = IP.Results;
    
    options.method = validatestring(options.method,vmthd);
end
end

%% ALIGN INPORT
function alignInport(phdl)
    % import third parties
    import me.sl.creator.inspect.linehandle
    import me.sl.creator.inspect.linesource
    import me.sl.creator.inspect.portposition

    lhdl = linehandle(phdl);
    % get existing inport line handles
    if ~ishandle(lhdl), return; end
    % get line source block handles
    sbhdl = linesource(lhdl);
    if ~ishandle(sbhdl), return; end
    % filter block types
    if ~ismember(get(sbhdl,'BlockType'),{'Inport','Constant'}), return; end
    
    pos = portposition(phdl);
    y = pos(2);
    me.sl.creator.mods.move('blockhandle',sbhdl,'yPosition',y,'yAlign','center');
end

%% ALIGN OUTPORT
function alignOutport(phdl)
    % import third parties
    import me.sl.creator.inspect.linehandle
    import me.sl.creator.inspect.linedestination
    import me.sl.creator.inspect.portposition

    lhdl = linehandle(phdl);
    % get existing inport line handles
    if ~ishandle(lhdl), return; end
    % get line source block handles
    sbhdl = linedestination(lhdl);
    if ~ishandle(sbhdl), return; end
    % filter block types
    if ~ismember(get(sbhdl,'BlockType'),{'Outport'}), return; end
    
    pos = portposition(phdl);
    y = pos(2);
    me.sl.creator.mods.move('blockhandle',sbhdl,'yPosition',y,'yAlign','center');
end