classdef integer

    properties (Access=private, Constant)
        ATTRIBUTES = {'scalar','integer'};
    end

    methods (Static)
        function validate(value)
            validateattributes(value,{'numeric'},me.types.integer.ATTRIBUTES);
        end

        function validateNonZero(value)
            validateattributes(value,{'numeric'},[me.types.integer.ATTRIBUTES,'nonzero']);
        end

        function validatePositive(value)
            validateattributes(value,{'numeric'},[me.types.integer.ATTRIBUTES,'positive']);
        end

        function validateNegative(value)
            validateattributes(value,{'numeric'},[me.types.integer.ATTRIBUTES,'<',0]);
        end

        function validateNonNegative(value)
            validateattributes(value,{'numeric'},[me.types.integer.ATTRIBUTES,'nonnegative']);
        end

        function validateNonPositive(value)
            validateattributes(value,{'numeric'},[me.types.integer.ATTRIBUTES,'<=',0]);
        end

        function validateVector(value,quantity)
            validateattributes(value,{'numeric'},{'integer','vector','numel',quantity});
        end

        function validateIndexing(value)
            if isscalar(value) && ischar(value)
                validatestring(value,{':'}); % get all
            elseif ~isempty(value)
                validateattributes(value,{'numeric'},{'integer','vector','positive'}); % get by indexing
            end
        end

        function [value,ok] = toValue(str)
            me.types.char.validatescalar(str);
            [value,ok] = str2num(str);
            me.types.integer.validate(value);
        end
    end
end

