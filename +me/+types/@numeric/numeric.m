classdef numeric
    
    properties (Access=private, Constant)
        ATTRIBUTES = {'scalar','real'};
    end
    
    methods (Static)
        function validate(value)
            validateattributes(value,{'numeric'},me.types.numeric.ATTRIBUTES);
        end
        
        function validateNonZero(value)
            validateattributes(value,{'numeric'},[me.types.numeric.ATTRIBUTES,'nonzero']);
        end
        
        function validatePositive(value)
            validateattributes(value,{'numeric'},[me.types.numeric.ATTRIBUTES,'positive']);
        end
        
        function validateNegative(value)
            validateattributes(value,{'numeric'},[me.types.numeric.ATTRIBUTES,'<',0]);
        end
        
        function validateNonNegative(value)
            validateattributes(value,{'numeric'},[me.types.numeric.ATTRIBUTES,'nonnegative']);
        end
        
        function validateNonPositive(value)
            validateattributes(value,{'numeric'},[me.types.numeric.ATTRIBUTES,'<=',0]);
        end
        
        function validateVector(value,quantity)
            validateattributes(value,{'numeric'},{'real','vector','numel',quantity});
        end
        
        function validateRegular(value)
            validateattributes(value,{'numeric'},[me.types.numeric.ATTRIBUTES,'finite']);
        end
        
        function validateRegularNonZero(value)
            me.types.numeric.validateRegular(value);
            me.types.numeric.validateNonZero(value);
        end
        
        function validateRegularPositive(value)
            me.types.numeric.validateRegular(value);
            me.types.numeric.validatePositive(value);
        end
        
        function validateRegularNegative(value)
            me.types.numeric.validateRegular(value);
            me.types.numeric.validateNegative(value);
        end
        
        function validateRegularNonNegative(value)
            me.types.numeric.validateRegular(value);
            me.types.numeric.validateNonNegative(value);
        end
        
        function validateRegularNonPositive(value)
            me.types.numeric.validateRegular(value);
            me.types.numeric.validateNonPositive(value);
        end
        
        function validateRegularVector(value,quantity)
            validateattributes(value,{'numeric'},{'real','vector','finite','numel',quantity});
        end
        
        function validateNormalization(value)
            validateattributes(value,{'numeric'},[me.types.numeric.ATTRIBUTES,'>=',0,'<=',1]);
        end
        
        function validateSampleTime(value)
            if value ~= -1
                 validateattributes(value,{'numeric'},[me.types.numeric.ATTRIBUTES,'positive','nonnan'],'',"SampleTime to be '-1' or");
            end
        end
        
        function [value,ok] = toValue(str)
            validateattributes(str,{'char','string'},{'scalartext','nonempty'});
            [value,ok] = str2num(str);
            me.types.numeric.validate(value);
        end
        
        function [tf] = isInteger(value)
            
            if me.types.numeric.isRegular(value)
                tf = round(value)==value;
            else
                tf =  false;
            end
        end
        
        function [tf] = isRegular(value)
            try
                me.types.numeric.validateRegular(value);
                tf = true;
            catch
                tf = false;
            end
        end
    end
end
