classdef mods    
    methods (Static)
        % prototypes
        [bhdl,btyp] = flip(varargin)
        [bhdl] = flipOutportTerminator(prop,blockname,varargin)
        [bhdl] = flipInportConstant(prop,blockname,value,varargin)
        [] = setmaskenable(prop,varargin)
    end
end

