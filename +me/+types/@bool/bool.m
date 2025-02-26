classdef bool
    methods (Static)        
        function validate(tfoz)
            fhdl = @(x)islogical(x)|isequal(x,0)|isequal(x,1);
            if ~all(arrayfun(@(c)fhdl(c),tfoz))
                error('Expected input to be logical, equal zero or equal one');
            end
        end
        
        function validateString(tfzo)
            import me.types.bool.validate
            import me.types.bool.toValue
            if ischar(tfzo)
                tfzo = toValue(tfzo);
            end
            validate(tfzo);
        end
        
        function validateLogical(tf)
            fhdl = @(x)islogical(x);
            if ~all(arrayfun(@(c)fhdl(c),tf))
                error('Expects input to be true or false');
            end
        end
        
        function tf = isEnable(str)
            tf = isequal(str,'on')|isequal(str,'off');
        end
        
        function str = toString(tf)
             if tf
               str = 'true';
             else
               str = 'false';
             end
        end
        
        function str = toEnable(tf)
            if tf
               str = 'on';
             else
               str = 'off';
             end
        end
        
        function tfzo = toValue(str)
            str = validatestring(str,{'true','false','0','1'});
            tfzo = eval(str);
        end
        
        function tf = toLogical(str)
            str = validatestring(str,{'true','false','0','1'});
            str = regexprep(str,{'0','1'},{'false','true'});
            tf = eval(str);
        end
        
        function zo = toNumeric(str)
            str = validatestring(str,{'true','false','0','1','on','off'});
            str = regexprep(str,{'false','true'},{'0','1'});
            str = regexprep(str,{'off','on'},{'0','1'});
            zo = eval(str);
        end
        
        function [str] = not(str)
            str = validatestring(str,{'true','false','0','1','on','off'});
            if me.types.bool.isEnable(str)
                zo = me.types.bool.toNumeric(str);
                str = me.types.bool.toEnable(~zo);
            else
                zo = me.types.bool.toNumeric(str);
                str = me.types.bool.toString(~zo);
            end
        end
            
    end
end

