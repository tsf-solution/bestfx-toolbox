function [T] = readInterfaceDescription(varargin)

%% PREPROCESSING
    
% Parse XLS File    
listNames = {
    'Type'
    'Description'
    'SwCpnt'
    'Group'
    'Signaldef'
    'Length'
    'Unit'
    'Gain'
    'Offset'
    'Min'
    'Max'
    'Size'
    'UsedRange'
    'DataType'
    'isSigned'
    'Comment'
};

listExclude = {
    'Description'
    'Unit'
    'UsedRange'
    'Comment'
};

% Gather options from user inputs
opts = processInputs(varargin{:});    

%% EXECUTE

% override import options
args = detectImportOptions(opts.file);
args.VariableNamesRange = 1;
args.VariableNames = opts.listNames;
args.SelectedVariableNames  = setdiff(opts.listNames,opts.listExclude);
% finally read xls file
T = readtable(opts.file,args);
% remove rows which are not complete
T = rmmissing(T);

% update table information
T = movevars(T,'SwCpnt','Before',1);
% add SignalName
T.SignalName = cellfun(@(c)determineSignalName(c),T.Signaldef,'UniformOutput',false);
T = movevars(T,{'Group','SignalName'},'After','SwCpnt');
% transform DataType
T.DataType = cellfun(@(c)determineDataType(c),T.DataType,'UniformOutput',false);
T = movevars(T,{'DataType','Length','Gain','Offset','Min','Max','Size'},'After','SignalName');
% Convert Type
T.isHw = cellfun(@(c)contains(c,{'HW'}),T.Type,'UniformOutput',true);
T.isNw = cellfun(@(c)contains(c,{'NW'}),T.Type,'UniformOutput',true);
T.isSw = cellfun(@(c)contains(c,{'SW'}),T.Type,'UniformOutput',true);
T.isIn = cellfun(@(c)contains(c,{'IN'}),T.Type,'UniformOutput',true);
T.isOut = cellfun(@(c)contains(c,{'OUT'}),T.Type,'UniformOutput',true);
T.isNvm = cellfun(@(c)contains(c,{'NVM'}),T.Group,'UniformOutput',true);

% remove columns from table
T.Signaldef = [];
T.Type = [];

%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.addParameter('blockhandle',gcbh,@(x)ishandle(x));
    IP.addParameter('file','InterfaceDescription.xlsx',@(x)isfile(x));
    IP.addParameter('listNames',listNames,@(x)iscellstr(x));
    IP.addParameter('listExclude',listExclude,@(x)iscellstr(x));
    IP.parse(varargin{:});
    options = IP.Results;
end
end

function [str] = determineSignalName(str)
    ids = strfind(str,'_');
    if ~isempty(ids)
        str = str(1:max(ids)-1);
    end
end

function [str] = determineDataType(str)
    switch lower(str)
        case 'f64'
            str = 'double';
        case 'f32'
            str = 'single';
        case 'u64'
            str = 'fixdt(0,64,2^0,0)';
        case 'u32'
            str = 'uint32';
        case 'u16'
            str = 'uint16';
        case 'u8'
            str = 'uint8';
        case 'u1'
            str = 'boolean';
        case 'b'
            str = 'boolean';
        case 'bool'
            str = 'boolean';
        case 's64'
            str = 'fixdt(1,64,2^0,0)';
        case 's32'
            str = 'int32';
        case 's16'
            str = 'int16';
        case 's8'
            str = 'int8';
        otherwise 
            str = 'double';
    end
end
