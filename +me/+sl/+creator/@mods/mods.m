classdef mods    
    methods (Static)
        % prototypes
        [] = align(varargin)
        [bhdl,btyp] = flip(varargin)
        [bhdl] = flipOutportTerminator(prop,blockname,varargin)
        [bhdl] = flipInportConstant(prop,blockname,value,varargin)
        [] = setmaskenable(prop,varargin)
        [] = setmaskvisibility(prop,varargin)
        [pos] = resize(varargin)
        [bhdls] = insert(varargin)
        [pos] = move(varargin)
    end
end

