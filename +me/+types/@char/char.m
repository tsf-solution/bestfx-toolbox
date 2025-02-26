classdef char

    methods (Static)

        function str = unicode(code)
            switch code
                case {'hookleftarrow'}
                    str = me.types.char.hookleftarrow();
            end
        end

        function validate(chr)
            me.types.char.validatescalartext(chr);
            fhdl = @(x)(numel(x) >= 0 & numel(x) <= 1);
            if ~fhdl(chr)
                error('Expected input to be scalar, including inputs with zero characters');
            end
        end

        function validatescalar(chr)
            me.types.char.validatescalartext(chr);
            fhdl = @(x)(isscalar(x));
            if ~fhdl(chr)
                error('Expected input to be scalar');
            end
        end

        function validatescalartext(str)
            fhdl = @(x)ischar(x) | isstring(x);
            if ~fhdl(str)
                error('Expected input to be class char or string');
            end
        end

        function validatestring(str, validStrings)
            validatestring(str, validStrings);
            if ~ismember(str, validStrings)
                error("Expected input to match one of these values:\n\n'%s'\n\nThe input, '%s', did not match any of the valid values.", strjoin(validStrings, "', '"), str);
            end
        end

    end

    methods (Static, Access = private)

        function str = hookleftarrow()
            if me.env.isoctave()
                str = char(' ');
            else
                str = char(hex2dec('21a9'));
            end
        end

    end

end
