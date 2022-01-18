function countertimerunit(varargin)

%% PREPROCESSING

% import third parties
import me.sl.utils.geteval
import me.sl.creator.mods.flipInportConstant
import me.sl.creator.mods.flipOutportTerminator

% Gather options from user inputs
opts = processInputs(varargin{:});

%% EXECUTE

% get value of dialog parameters
bvar = geteval(opts.blockhandle,'VariantType');
uppr = geteval(opts.blockhandle,'UpperLimit');
incr = geteval(opts.blockhandle,'Increment');
decr = geteval(opts.blockhandle,'Decrement');
init = geteval(opts.blockhandle,'InitialValue');
usrc = geteval(opts.blockhandle,'UpperLimitSourcePort');
isrc  = geteval(opts.blockhandle,'IncrementSourcePort');
dsrc  = geteval(opts.blockhandle,'DecrementSourcePort');
isrc  = geteval(opts.blockhandle,'InitialValueSourcePort');

switch(opts.clbk)
    case 'init'
        % validate value
%         validateString(ic);
        % attribute format string
        setafs();
        % hide/show ports
        flipInportConstant('UpperLimitSourcePort','lim','UpperLimit',...
            'blockhandle',opts.blockhandle,'portposition',1,'outdatatypestr','UpperLimitDataType');
        flipInportConstant('EnableSourcePort','TF','true',...
            'blockhandle',opts.blockhandle,'portposition',2);
        flipInportConstant('IncrementSourcePort','incr','Increment',...
            'blockhandle',opts.blockhandle,'portposition',3,'outdatatypestr','IncrementDataType');
        flipInportConstant('DecrementSourcePort','decr','Decrement',...
            'blockhandle',opts.blockhandle,'portposition',4,'outdatatypestr','DecrementDataType');
        flipInportConstant('InitialValueSourcePort','x0','InitialValue',...
            'blockhandle',opts.blockhandle,'portposition',5,'outdatatypestr','InitialValueDataType');
        flipInportConstant('ResetSourcePort','rs','false',...
            'blockhandle',opts.blockhandle,'portposition',6);
        flipOutportTerminator('CounterTimerValueSinkPort','n',...
            'blockhandle',opts.blockhandle,'portposition',2);
        flipOutportTerminator('CounterTimerStateSinkPort','st',...
            'blockhandle',opts.blockhandle,'portposition',1);
        
        
        
        
end

%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = false;
    IP.addParameter('clbk','init',@(x)ischar(x));
    IP.addParameter('blockhandle',gcbh,@(x)ishandle(x));
    IP.parse(varargin{:});
    options = IP.Results;
    
    options.clbk = validatestring(options.clbk,{'init'});
end

%% ATTRIBUTE FORMAT STRING
function setafs() % nested function
    
%     import me.types.bool.toValue
%     import me.types.bool.toString
%     
%     afstr = '';
%     if toValue(ic)
%         afstr = sprintf('%sIC: %s\n',afstr,toString(ic));
%     end
%     set(opts.blockhandle,'AttributesFormatString',afstr);
end
end