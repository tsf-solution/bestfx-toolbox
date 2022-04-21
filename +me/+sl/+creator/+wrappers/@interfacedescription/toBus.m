function [] = toBus(varargin)

%% PREPROCESSING

% import third parties
import me.sl.creator.parser.xlsx

% Gather options from user inputs
[opts, varargin] = processInputs(varargin{:});


%% EXECUTE
T = xlsx.readInterfaceDescription(varargin{:});

% assign buses to a workspace foreach software component
cellfun(@(c)foreachSwCpnt(c),unique(T.SwCpnt),'UniformOutput',false);


%% EVALUATION INPUT ARGUMENTS
function [options,unmatched] = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = true;
    IP.addParameter('workspace','base',@(x)validateModelWorkspace(x));
    IP.parse(varargin{:});
    options = IP.Results;
    unmatched = me.utils.namedargs2cell(IP.Unmatched);
end

function tf = validateModelWorkspace(x)
    if ischar(x)
        assert(ismember(x,{'base'}),'Char workspace is ''%s'' but must match ''base''.',x);
    else
        assert(isa(x,'Simulink.ModelWorkspace'),'''%s'' is no valid model workspace.',x);
    end
    tf = true;
end

%% categorize table data
function foreachSwCpnt(swcpnt) % nested function
    S = T(strcmp(T.SwCpnt,swcpnt),:);
    getbusin(S,me.string.camelcase(lower(swcpnt)));
    getbusout(S,me.string.camelcase(lower(swcpnt)));
end

function [] = getbusin(T,swcpnt) % nested function
    T = T(T.isIn == true,:);
    C = {getbushw(T), [swcpnt,'InHw'];...
         getbussw(T), [swcpnt,'InSw'];...
         getbusnw(T), [swcpnt,'InNw']};
    
    createBusOfBuses(C,[swcpnt,'In']);
end

function [] = getbusout(T,swcpnt) % nested function
    T = T(T.isOut == true,:);        
    C = {getbushw(T), [swcpnt,'OutHw'];...
         getbussw(T), [swcpnt,'OutSw'];...
         getbusnw(T), [swcpnt,'OutNw']};
    
    createBusOfBuses(C,[swcpnt,'Out']);
end

%%  assign buses to a workspace
function [e,b] = createBusOfBuses(C,busalias) % nested function
    % remove previous buses
    estr = ['clear ',busalias,'*_t'];
    evalin(opts.workspace,estr);
    
    busname = ['bus' busalias];
    bustype = [busalias '_t'];
    E = cellfun(@(s,t)createBusOfSignals(s,t),C(:,1),C(:,2),'UniformOutput',false);
    b = Simulink.Bus;
    b.Description = busname;
    b.Elements = [E{~cellfun('isempty',E)}];
    assignin(opts.workspace,bustype,b);
    e = busFromAlias(busalias);
end

function [e,b] = createBusOfSignals(T,busalias) % nested function
    busname = nameFromAlias(busalias);
    bustype = typeFromAlias(busalias);
    
    E = arrayfun(@(s)buselement(s),table2struct(T),'UniformOutput',true);
    
    b = Simulink.Bus;
    b.Description = busname;
    if ~isempty(E)
        b.Elements = E;
        assignin(opts.workspace,bustype,b);
        e = busFromAlias(busalias);
    else
        e = [];
    end
end
end

%% auxilary functions
function B = getbushw(T)
    B = T(T.isHw == true,:);
end

function B = getbussw(T)
    B = T(T.isSw == true,:);
end

function B = getbusnw(T)
    B = T(T.isNw == true,:);
end

function e = buselement(S)
    e = Simulink.BusElement;
    e.Name = S.SignalName;
    e.DataType = S.DataType;
end

function e = busFromAlias(str)
    e = Simulink.BusElement;
    e.Name = nameFromAlias(str);
    e.DataType = typeFromAlias(str);
end

function str = typeFromAlias(str)
    str = [str '_t'];
end

function str = nameFromAlias(str)
 str = ['bus' str];
end

