function [qty] = portnumber(varargin)
    qty = numel(me.sl.creator.inspect.porthandle(varargin{:}));
end
