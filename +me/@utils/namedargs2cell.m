function [C] = namedargs2cell(S)
%NAMEDARGS2CELL convert structure containing name-value pairs to cell row array

if exist('namedargs2cell','builtin')
    C = namedargs2cell(S);
else
    C = [fieldnames(S) struct2cell(S)]';
    C = C(:)';
end