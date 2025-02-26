function [map] = stihl(m)

if nargin < 1
   f = get(groot,'CurrentFigure');
   if isempty(f)
      m = size(get(groot,'DefaultFigureColormap'),1);
   else
      m = size(f.Colormap,1);
   end
end

c = [   243     122     31
        243      80     31
        255       0     31
        255     200      4
         58     171     57
         35      44     51] / 255;

map = c(rem(0:m-1,size(c,1))+1,:);