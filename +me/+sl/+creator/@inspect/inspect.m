classdef inspect    
    methods (Static)
        % prototypes
        [lhdl] = linehandle(phdl)
        [bhdl] = linesource(lhdl)
        [bhdl] = linedestination(lhdl)
        [pos] = portposition(phdl)
        [qty] = portnumber(phdl)
        [phdl] = porthandle(bhdl,varargin)
        [bhdl] = blockhandle(str)
        [str] = blockname(bhdl)
        [str] = blockpath(bhdl)
        [str] = blockfullpath(bhdl)
        [str] = blocktype(bhdl)
    end
end

