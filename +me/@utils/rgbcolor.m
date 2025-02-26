function [rgb] = rgbcolor(str)
% RGBCOLOR covert textual colorname to rgb value

%% PREPROCESSING

% Cross-functional variables
cshort = {'k','b','g','c','r','m','y','w','o'};
clong  = {'black','blue','green','cyan','red','magenta','yellow','white','orange'};
clight = {'grey','violet','lightgreen','lightcyan','lightred','pink','lightyellow','lightgrey','lightorange'};

% Default values for required input arguments
if  nargin<1
    demo();
    return;
end

%% EXECUTE

% validate supported color string
str = validatestring(str,[cshort,clong,clight]);

idx = index();

if idx == 9 % orange
    rgb = [1,0.5,0];
else
    rgb = rem(floor((idx-1) * [0.25 0.5 1]),2);
end

if ismember(str,clight)
    if sum(rgb) >= 3
        rgb = max(0,min(rgb - 0.25,1)); % light grey
    else
        rgb = max(0,min(rgb + 0.5,1));
    end
end

%% GET COLOR INDEX
function idx = index()  % nested function
[tf,idx] = ismember(str,cshort);   
if tf, return;end
[tf,idx] = ismember(str,clong);
if tf, return;end
[tf,idx] = ismember(str,clight);
if tf, return;end
end

%% DEMO
function demo()  % nested function

    mpath = "me.utils";
    msep=".";
    mname = "rgbcolor";
    mfile = strcat(mpath,msep,mname);
    
    evalin('base','clc');
    
    % description and help link
    syntax="rgb = rgbcolor(str);";
    help=strcat("<a href=""matlab:clc;help ",mfile,""">here</a>");
    fprintf('Syntax: %s click %s for details.\n\n',syntax,help);

    fprintf('>>> Demo <<< supported colors and aligned rgb values:\n\n');
    cellfun(@(c)demoloop(mfile,c),[cshort,clong,clight])
end
end

%% DEMO LOOP
function demoloop(mfile,color)
    text=strcat(mfile,"('",color,"');");
    fstr = me.string.replacemarks(text,'apostrophes',"''");
    [~,rgb] = evalc(fstr);
    fprintf('\t[%4g,%4g,%4g] = %s\n',rgb(:),fstr);
end
