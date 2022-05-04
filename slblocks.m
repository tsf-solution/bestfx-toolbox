function blkStruct = slblocks
% This function specifies that a specified library appears
% in the Library Browser with a the specified name

    % is the name of the library
    Browser.Library = me.sl.cfg.meSimulinkLibraryName;
    % speified library name that appears in the Library Browser
    Browser.Name = me.sl.cfg.meSimulinkLibraryLabel;

    blkStruct.Browser = Browser;     
end

