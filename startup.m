function startup
    this = '.me BestFX';
    warning OFF BACKTRACE;
    tf = true;
    % tf = tf & validatetoolbox('<toolbox-name>');
    if ~tf
        warning("Toolbox '%s' has invalid dependencies. Resolve warnings above before use!",this);
    end
    warning ON BACKTRACE;
end

function tf = validatetoolbox(name,version)
    % input argument check
    narginchk(1,2);
    
    % check toolbox availability
    TBXS = ver;
    tf = any(cellfun(@(c)strcmp(c,name),{TBXS.Name}));
    if ~tf
        warning("Toolbox '%s' is required but not found.",name);
        return;
    end
    
    % optional: check toolbox version
    if ~isempty(version)
        tf = ~verLessThan(name, version);
        if ~tf
            warning("Toolbox '%s' is outdated. Version %s is required.",name,version);
            return;
        end
    end
end



