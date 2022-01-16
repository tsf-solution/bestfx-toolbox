classdef utils    
    methods (Static)
        [bhdls] = findblocks(blocktype, varargin)
        
        function hdl = toHandle(str)
            if ishandle(str)
                hdl = str;
            else
                hdl = get_param(str,'Handle');
            end
        end
        
        function autoname(bhdl,re)
            if nargin < 2
                re = get( bhdl, 'BlockType');
            end
            if not(isequal(regexp(get(bhdl,'Name'),re),1))
                set( bhdl, 'ShowName', 'on');
            end
        end
        
        function tf = filterblocktype(bhdl,re)
            tf = isequal(regexp(get(bhdl,'BlockType'),re), 1);
        end
        
        function tf = filteriop(bhdl)
            % get math blocks which have attribute 'SaturateOnIntegerOverflow'
            if ~isfield(set(bhdl),'SaturateOnIntegerOverflow')
                tf = false;return;
            end
            % get all blocks which have 'SaturateOnIntegerOverflow' enabled
            tf = isequal(get(bhdl,'SaturateOnIntegerOverflow'),'on');
        end
    end
end

