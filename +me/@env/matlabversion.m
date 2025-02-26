function vrsn = matlabversion(varargin)
% MATLABVERSION return MATLAB version in different formats of the
% current used version.
%
%      'format'            - Choose between the strings 'label' (default),
%                           'full', 'short', 'lean', 'id' or 'release'.
%

%% PREPROCESSING

% Gather options from user inputs
opts = processInputs(varargin{:});


%% EXECUTE
% 'num': 8.6
if strcmpi(opts.format,'num')
    vrsn = sscanf(version, '%d.%d.%d');
    vrsn = 10.^(0:-1:-(length(vrsn)-1)) * vrsn;
% 'full': '8.6.0.267246 (R2015b)'
elseif strcmpi(opts.format,'full')
    vrsn = char(version);
% 'short': '8.6.0'
elseif strcmpi(opts.format,'short')
    vrsn = char(regexp(version, '^[\d]+\.[\d]+\.[\d]+','match'));
% 'lean': '8.6'
elseif strcmpi(opts.format,'lean')
    vrsn = char(regexp(version, '^[\d]+\.[\d]+\.[^0]+','match'));
    if isempty(vrsn)
        vrsn = char(regexp (version, '^[\d]+\.[\d]+','match'));
    end
% 'id': '8.6.0.267246'
elseif strcmpi(opts.format,'id')
    vrsn = char(regexp (version, '^[\d\.]+','match'));
% 'release': '2015b'
elseif strcmpi(opts.format,'release')
    vrsn = version('-release');
% 'name': 'R2015b'
else
    vrsn = char(regexp(version, 'R[^\)]+','match'));
end

%% EVALUATION INPUT ARGUMENTS
function options = processInputs(varargin) % nested function
    IP = inputParser;
    IP.KeepUnmatched = true;
    try % 'addParameter', introduced in R2013b
        IP.addParameter('format','label',@(x)ischar(x))
    catch %'addParamValue', introduced in R2007a
        IP.addParamValue('format','label',@(x)ischar(x))
    end
    IP.parse(varargin{:});
    options = IP.Results;
end
end

