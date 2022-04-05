function sl_customization(cm)

    % Register custom menu function
    cm.addCustomMenuFcn('Simulink:ContextMenu', @clbkContextMenu);
    
    %% define the custom menu function (nested functions)
    function schemaFcns = clbkContextMenu(callbackInfo) 
        schemaFcns = {@containerSettings};
    end

    %% container: settings (nested functions)
    function schema = containerSettings(callbackInfo)
        % Make a new context menu entry
        schema = sl_container_schema;
        schema.label = 'Settings me.';
        schema.childrenFcns = {...
            @actionHeightStandard,...
            @actionHeightCompact,...
            @actionHeightExtra,...
            'separator',...    
            @actionWidthNormal,...
            @actionWidthTiny,...
            @actionWidthSmall,...
            @actionWidthLarge,...
            @actionWidthHuge,...
            'separator',...
            @actionSizeMini,...
          };
    end
    
    %% actions: resize
    function schema = actionHeightStandard(callbackInfo)
        schema = sl_action_schema;
        schema.label = 'Height Standard';
        schema.callback = @clbkSizeHeight;
        schema.userdata = 'standard';
        schema.state = 'ENABLED';
    end

    function schema = actionHeightCompact(callbackInfo)
        schema = sl_action_schema;
        schema.label = 'Height Compact';
        schema.callback = @clbkSizeHeight;
        schema.userdata = 'compact';
        schema.state = 'ENABLED';
    end

    function schema = actionHeightExtra(callbackInfo)
        schema = sl_action_schema;
        schema.label = 'Height Extra';
        schema.callback = @clbkSizeHeight;
        schema.userdata = 'extra';
        schema.state = 'ENABLED';
    end

    function schema = actionWidthNormal(callbackInfo)
        schema = sl_action_schema;
        schema.label = 'Width Normal';
        schema.callback = @clbkSizeWidth;
        schema.userdata = 'normal';
        schema.state = 'ENABLED';
    end

    function schema = actionWidthTiny(callbackInfo)
        schema = sl_action_schema;
        schema.label = 'Width Tiny';
        schema.callback = @clbkSizeWidth;
        schema.userdata = 'tiny';
        schema.state = 'ENABLED';
    end

    function schema = actionWidthSmall(callbackInfo)
        schema = sl_action_schema;
        schema.label = 'Width Small';
        schema.callback = @clbkSizeWidth;
        schema.userdata = 'small';
        schema.state = 'ENABLED';
    end

    function schema = actionWidthLarge(callbackInfo)
        schema = sl_action_schema;
        schema.label = 'Width Large';
        schema.callback = @clbkSizeWidth;
        schema.userdata = 'large';
        schema.state = 'ENABLED';
    end

    function schema = actionWidthHuge(callbackInfo)
        schema = sl_action_schema;
        schema.label = 'Width Huge';
        schema.callback = @clbkSizeWidth;
        schema.userdata = 'huge';
        schema.state = 'ENABLED';
    end

    function schema = actionSizeMini(callbackInfo)
        schema = sl_action_schema;
        schema.label = 'Size Mini';
        schema.callback = @clbkSize;
        schema.userdata = 'mini';
        schema.state = 'ENABLED';
    end

    %% function callbacks: resize
    function clbkSizeWidth(callbackInfo)
        bhdls = find_system(me.sl.utils.toHandle(bdroot),'Selected','on');
        arrayfun(@(c)me.sl.creator.mods.resize('blockhandle',c,'width',callbackInfo.userdata),bhdls,'UniformOutput',false);
    end

    function clbkSizeHeight(callbackInfo)
        bhdls = find_system(me.sl.utils.toHandle(bdroot),'Selected','on');
        arrayfun(@(c)me.sl.creator.mods.resize('blockhandle',c,'height',callbackInfo.userdata),bhdls,'UniformOutput',false);
    end

    function clbkSize(callbackInfo)
        bhdls = find_system(me.sl.utils.toHandle(bdroot),'Selected','on');
        arrayfun(@(c)me.sl.creator.mods.resize('blockhandle',c,'width',callbackInfo.userdata,'height',callbackInfo.userdata),bhdls,'UniformOutput',false);
    end

end