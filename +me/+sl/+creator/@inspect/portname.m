function [str] = portname(varargin)
    bhdls = me.sl.utils.findports(varargin{:});
    str = get(bhdls,'PortName');
end