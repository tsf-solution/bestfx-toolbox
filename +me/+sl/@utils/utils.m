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
        
        function str = toSystem(shdl)
            if ishandle(shdl)
                bpath = get(shdl,'Path');
                bname = get(shdl,'Name');
                if strcmpi(get(shdl,'Type'),'block_diagram')
                    str = [bpath];
                else
                    str = [bpath '/' bname];
                end
            else
                str = shdl;
            end
        end
        
        function str = geteval(bhdl,key)
            str = get(bhdl,key);
            try
                str = mat2str(evalin('base',str));
            catch
                % do nothing
            end
        end
        
        function autoname(bhdl,re)
            if nargin < 2
                re = sprintf('^%s',get(bhdl,'BlockType'));
            end
            if not(isequal(regexp(get(bhdl,'Name'),re),1))
                set(bhdl,'ShowName','on');
            end
        end
        
        function tf = filtermasktype(bhdl,re)
            tf = isequal(regexp(get(bhdl,'MaskType'),re), 1);
        end
        
        function tf = filterblocktype(bhdl,re)
            tf = isequal(regexp(get(bhdl,'BlockType'),re), 1);
        end
        
        function tf = filtersampletime(bhdl)
            % check if attribute exists
            if ~isfield(set(bhdl),'SampleTime')
                % default case is inherit sample time
                tf = true;return;
            end
            % get attribute state
            tf = isequal(regexp(get(bhdl, 'SampleTime'),'^(-1)$'),1);
        end
        
        function tf = filterinitialcondition(bhdl)
            tf = isequal(regexp(get(bhdl, 'InitialCondition'),'^(0|0\.0)$'),1);
        end
        
        function tf = filteroutdatatypestr(bhdl)
            tf = isequal(regexp(get(bhdl, 'OutDataTypeStr'),'^(Inherit: auto)$'),1);
        end
        
        function tf = filterportdimensions(bhdl)
            tf = isequal(regexp(get_param(bhdl,'PortDimensions'),'-1'),1);
        end
        
        function tf = filteriop(bhdl)
            % check if attribute exists
            if ~isfield(set(bhdl),'SaturateOnIntegerOverflow')
                % default case is iop disabled
                tf = false;return;
            end
            % get attribute state
            tf = isequal(get(bhdl,'SaturateOnIntegerOverflow'),'on');
        end
        
        [tf] = isLibrary(bdhdl)
        [tf] = isLoaded(bdhdl)
    end
end

