function tf = isLoaded(bd)
    if nargin<1
        bd = bdroot;
    end
    bd = me.sl.utils.toSystem(bd);
    tf = ismember(bd,find_system('type','block_diagram'));
end