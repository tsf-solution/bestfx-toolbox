function model

bdhdl = get_param(bdroot,'Handle');

set(bdhdl,'HideAutomaticNames','off');
set(bdhdl,'ShowPortDataTypes','on');
set(bdhdl,'ShowLineDimensions','on');
if regexp(get( bdhdl, 'LibraryLinkDisplay'),'none')
    set(bdhdl,'LibraryLinkDisplay','user');
end

end

