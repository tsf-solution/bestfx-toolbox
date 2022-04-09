classdef utils    
    methods (Static)
        
        [bhdls] = findblocks(blocktype, varargin)
        [bhdls] = findports(varargin)
        [] = autoname(bhdl,re)
        [tf] = filteriop(bhdl)
        [tf] = filtersampletime(bhdl)
        [tf] = isLibrary(bdhdl)
        [tf] = isLoaded(bdhdl)
        [hdl] = toHandle(str)
        [str] = toSystem(shdl)
        [str] = geteval(bhdl,key)
        
        function [tf] = filtermasktype(bhdl,re)
            tf = isequal(regexp(get(bhdl,'MaskType'),re), 1);
        end
        
        function [tf] = filterblocktype(bhdl,re)
            tf = isequal(regexp(get(bhdl,'BlockType'),re), 1);
        end
        
        function [tf] = filterinitialcondition(bhdl)
            tf = isequal(regexp(get(bhdl, 'InitialCondition'),'^(0|0\.0)$'),1);
        end
        
        function [tf] = filteroutdatatypestr(bhdl)
            tf = isequal(regexp(get(bhdl, 'OutDataTypeStr'),'^(Inherit: auto)$'),1);
        end
        
        function [tf] = filterportdimensions(bhdl)
            tf = isequal(regexp(get_param(bhdl,'PortDimensions'),'-1'),1);
        end
        
    end
end

