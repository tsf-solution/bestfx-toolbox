classdef mods    
    methods (Static)
        % prototypes
        [bhdl,btyp] = flip(varargin)
        [bhdl] = flipOutportTerminator(prop,blockname,varargin)
        [bhdl] = flipInportConstant(prop,blockname,value,varargin)
        [phdls] = ports(varargin)
        [str] = blockname(bhdl)
        [str] = blockpath(bhdl)
        [str] = blockfullpath(bhdl)
        [str] = blocktype(bhdl)
    end
end

