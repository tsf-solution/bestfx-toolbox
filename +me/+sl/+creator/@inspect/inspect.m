classdef inspect    
    methods (Static)
        % prototypes
        [n] = portnumber(varargin)
        [str] = portname(varargin)
        [phdls] = porthandle(varargin)
        [bhdl] = blockhandle(str)
        [str] = blockname(bhdl)
        [str] = blockpath(bhdl)
        [str] = blockfullpath(bhdl)
        [str] = blocktype(bhdl)
    end
end

