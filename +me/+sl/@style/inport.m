function inport(depth)

% import third parties
import me.sl.utils.findblocks

% find blocks
bhdls = findblocks('Inport','depth',depth);

% Set foreground color
set( bhdls, 'ForegroundColor', 'green');
set( bhdls, 'BackgroundColor', 'white');
set( bhdls, 'AttributesFormatString', '');

% % Set attributes format string
% for i=1 : length(bhdls)
% 
%     bhdl = bhdls(1);
% 
%     attrstr = '';
% 
%     if not(isequal(regexp(get_param(bhdl,'OutDataTypeStr'),'Inherit: auto'),1))
%         if isequal(regexp(get_param(bhdl,'OutDataTypeStr'),'Bus'),1)
%             continue;
%         end
%         % add OutDataTypeStr attributes to string which should be displayed
%         attrstr = sprintf('%s%s\n', attrstr, 'OutDataTypeStr: %<OutDataTypeStr>');
%     end
% 
%     if not(isequal(regexp(get_param(bhdl,'PortDimensions'),'-1'),1))
%         % add PortDimensions attributes
%         attrstr = sprintf('%s%s\n', attrstr, 'PortDimensions: %<PortDimensions>');
%     end
% 
%     % display attributes
%     set_param( bhdl, 'AttributesFormatString', attrstr);
% end

end

