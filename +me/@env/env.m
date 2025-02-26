classdef env
    methods (Static)
        vrsn = matlabversion(varargin)
        tf = matlabversioncheck(str,varargin)
        [moninfo] = screendevice(varargin)
        [tf] = isoctave()
        [] = octaveloadpackage(str)
    end
end

