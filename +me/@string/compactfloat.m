function [str] = compactfloat(value)
    me.types.numeric.validate(value);
    str = sprintf('%g',value);
end