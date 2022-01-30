classdef inspect    
    methods (Static)
        % prototypes
        [phdls] = ports(varargin)
        [bhdl] = blockhandle(str)
        [str] = blockname(bhdl)
        [str] = blockpath(bhdl)
        [str] = blockfullpath(bhdl)
        [str] = blocktype(bhdl)
    end
end

