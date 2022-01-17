classdef mods    
    methods (Static)
        % prototypes
        [] = flipOutportTerminator(prop,blockname,varargin)
        [phdls] = ports(varargin)
        [str] = blockname(bhdl)
        [str] = blockpath(bhdl)
        [str] = blockfullpath(bhdl)
        [str] = blocktype(bhdl)
    end
end

