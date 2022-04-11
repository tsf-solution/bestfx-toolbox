function c2d(varargin)

%% PREPROCESSING

% import third parties
import me.sl.utils.geteval

% Gather options from user inputs
opts = processInputs(varargin{:});

%% EXECUTE

% get value of dialog parameters
nvar = geteval(opts.blockhandle,'Quantity');

% validate value
me.types.integer.validatePositive(me.types.numeric.toValue(nvar));

args = {'systemhandle',opts.blockhandle,'depth',1};
ihdls = me.sl.utils.findblocks('Inport',args{:});
ohdls = me.sl.utils.findblocks('Outport',args{:});
rhdls = me.sl.utils.findblocks('RateTransition',args{:});
thdls = me.sl.utils.findblocks('DataTypeConversion',args{:});
nmax = max([numel(ihdls),numel(ohdls),numel(rhdls),numel(thdls)]);
ndes = me.types.numeric.toValue(nvar);

args = [args,{'attr','Name'}];
for idx=1:max(nmax,ndes)
    update();
end

%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = false;
    IP.addParameter('blockhandle',gcbh,@(x)ishandle(x));
    IP.addParameter('debug',false,@(x)me.types.bool.validate(x));
    IP.parse(varargin{:});
    options = IP.Results;
end

function update()
    
    ihdl = me.sl.utils.findblocks(sprintf('u%d',idx),args{:});
    ohdl = me.sl.utils.findblocks(sprintf('y%d',idx),args{:});
    rhdl = me.sl.utils.findblocks(sprintf('RateTransition%d',idx),args{:});
    thdl = me.sl.utils.findblocks(sprintf('DataTypeConversion%d',idx),args{:});

    % delete
    if idx > ndes
        if opts.debug,fprintf('c2d delete index %d\n',idx);end
        deleteBlockGroup();
    % add
    elseif idx <= ndes
        if isbrokenGroup(ihdl,ohdl,rhdl,thdl)
            if opts.debug,fprintf('c2d repair index %d\n',idx);end
            deleteBlockGroup();
        elseif idx == ndes
            if opts.debug,fprintf('c2d add/update index %d\n',idx);end
        else
            if opts.debug,fprintf('c2d add/skip index %d\n',idx);end
        end
        addBlockGroup();
    end
    
    function addBlockGroup()
        ihdl = addInport(ihdl,idx);
        rhdl = addRateTransition(rhdl,ihdl,idx);
        thdl = addDataTypeConversion(thdl,rhdl,idx);
        ohdl = addOutport(ohdl,thdl,idx);
    end
    
    function deleteBlockGroup()
        ihdl = deleteBlockWithLines(ihdl);
        rhdl = deleteBlockWithLines(rhdl);
        thdl = deleteBlockWithLines(thdl);
        ohdl = deleteBlockWithLines(ohdl);
    end
end

function [ihdl] = addInport(ihdl,idx)
    if isempty(ihdl)
        [w,h] = me.sl.creator.settings.size('widthType','port','heightType','port');
        [x,y] = me.sl.creator.settings.origin('type','inport','horzShift',1,'vertShift',idx);
        ihdl = me.sl.creator.mods.insert(sprintf('u%d',idx),...
            'systemhandle',opts.blockhandle,...
            'libraryblock','built-in/Inport',...
            'position',[x y x+w y+h]);
    end
end

function [rhdl,lhdl] = addRateTransition(rhdl,ihdl,idx)
    if isempty(rhdl)
        [w,h] = me.sl.creator.settings.size('widthType','mini','heightType','mini');
        [x,y] = me.sl.creator.settings.origin('type','subsystem','vertShift',idx);
        rhdl = me.sl.creator.mods.insert(sprintf('RateTransition%d',idx),...
            'systemhandle',opts.blockhandle,...
            'libraryblock','built-in/RateTransition',...
            'position',[x y x+w y+h]);
        set(rhdl,'outportsampletime','OutputPortSampleTime');
        lhdl = add_line(gcb,[get(ihdl,'name') '/1'],[get(rhdl,'name') '/1'],'autorouting','on');
    end
end

function [thdl,lhdl] = addDataTypeConversion(thdl,rhdl,idx)
    if isempty(thdl)
        [w,h] = me.sl.creator.settings.size('widthType','small','heightType','compact');
        [x,y] = me.sl.creator.settings.origin('type','subsystem','horzShift',1,'vertShift',idx);
        thdl = me.sl.creator.mods.insert(sprintf('DataTypeConversion%d',idx),...
            'systemhandle',opts.blockhandle,...
            'libraryblock','built-in/DataTypeConversion',...
            'position',[x y x+w y+h]);
        set(thdl,'outdatatypestr',get(opts.blockhandle,'OutportDataType'));
        lhdl = add_line(gcb,[get(rhdl,'name') '/1'],[get(thdl,'name') '/1'],'autorouting','on');
    end
end

function [thdl,lhdl] = addOutport(ohdl,thdl,idx)
    if isempty(ohdl)
        [w,h] = me.sl.creator.settings.size('widthType','port','heightType','port');
        [x,y] = me.sl.creator.settings.origin('type','outport','horzShift',-1,'vertShift',idx);
        ohdl = me.sl.creator.mods.insert(sprintf('y%d',idx),...
            'systemhandle',opts.blockhandle,...
            'libraryblock','built-in/Outport',...
            'position',[x y x+w y+h]);
        lhdl = add_line(gcb,[get(thdl,'name') '/1'],[get(ohdl,'name') '/1'],'autorouting','on');
    end
end
end

function tf = isbrokenGroup(varargin)
    unique(cellfun(@(a)isempty(a),varargin));
    tf = ~isscalar(unique(cellfun(@(a)isempty(a),varargin)));
end

function [hdl] = deleteBlockWithLines(hdl)
    if ~isempty(hdl)
        lhdls = get(hdl,'LineHandles');
        arrayfun(@(a)delete_line(a),lhdls.Inport(lhdls.Inport ~= -1));
        arrayfun(@(a)delete_line(a),lhdls.Outport(lhdls.Outport ~= -1));
        delete_block(hdl);
        hdl = [];
    end
end
