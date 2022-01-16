function outport(depth)

% import third parties
import me.sl.utils.findblocks
import me.sl.utils.toHandle

% find blocks
bhdls = findblocks('Outport','depth',depth);

% Set foreground color
set( bhdls, 'ForegroundColor', 'blue');
set( bhdls, 'BackgroundColor', 'white');
set( bhdls, 'AttributesFormatString', '');

% % Set attributes format string
% for i=1 : length(bhdls)
%     
%     bhdl = bhdls(1);
%     
%     % check if parent is triggered or enabled subsystem
%     shdl = toHandle(get(bhdl,'Parent'));
%     if isequal(numel(findblocks('EnablePort|TriggerPort|ActionPort','shdl',shdl,'regexp','on')),1)
%         
%         if isequal(regexp(get_param(bhdl,'OutputWhenDisabled'),'reset'),1)
%             % display reset attributes
%             set_param( bhdl, 'AttributesFormatString', 'OutputWhenDisabled: %<OutputWhenDisabled> \n InitialOutput: %<InitialOutput>');
%         else
%             % display hold attributes
%             set_param( bhdl, 'AttributesFormatString', 'OutputWhenDisabled: %<OutputWhenDisabled>');
%         end
%     end
% end

end

