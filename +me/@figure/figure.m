classdef figure < handle
    properties
        handle; % figure handle
        axes; % subplot axes handles
    end
    
    properties( Access = protected )
        rows; % subplot rows
        cols; % subplot columns
        num; % subplot amount
    end
    
    methods
        
        % constructor
        function obj = figure(varargin)
            
            if mod(nargin,2) % odd
                obj.handle = figure(varargin{1});
                varargin(1) = [];
            end
            
            % Gather options from input arguments
            [opts,varargin] = processInputs(varargin{:});
            
            % Default values for required input arguments
            if nargin <= 0 % empty
                obj.handle = figure();
            elseif ishandle(obj.handle) % was odd
                if nargin > 1
                    set(obj.handle,varargin{:});
                end
            else % even
                obj.handle = figure(varargin{:});
            end
            
            obj.layoutwindow('rows',opts.layoutwindow(1,1),'cols',opts.layoutwindow(1,2));
            obj.layoutfigure('rows',opts.layoutfigure(1,1),'cols',opts.layoutfigure(1,2));

            % EVALUATION INPUT ARGUMENTS
            function [options,unmatched] = processInputs(varargin) % nested function
                IP = inputParser;
                IP.KeepUnmatched = true;
                IP.addParameter('layoutwindow',[2 4],@(x)validateattributes(x,{'numeric'},{'positive','integer','ncols',2}));
                IP.addParameter('layoutfigure',[1 1],@(x)validateattributes(x,{'numeric'},{'positive','integer','ncols',2}));
                IP.parse(varargin{:});
                options = IP.Results;
                unmatched = me.utils.namedargs2cell(IP.Unmatched);
            end
        end
        
        function plothandle = subplot(obj,id,X,Y,varargin)
            set(groot,'CurrentFigure',obj.handle);
            subplot(obj.rows,obj.cols,id);
            plothandle = plot(X,Y,varargin{:});
            obj.axes(id) = gca;
        end
        
        function draw(obj)
            set(groot,'CurrentFigure',obj.handle);
            set(obj.handle,'Visible','on');
            linkaxes(obj.axes,'x');
        end
        
        function axishandle = illustrate(obj,id,varargin)
            
            % Gather options from input arguments
            opts = processInputs(varargin{:});
            % set grid
            if strcmp(opts.grid,'on'),grid on;else, grid off;end
            % set labels
            obj.xlabel(id,opts.xlabel);
            obj.ylabel(id,opts.ylabel);
            axishandle = obj.title(id,opts.title);
            
            % EVALUATION INPUT ARGUMENTS
            function [options] = processInputs(varargin) % nested function
                IP = inputParser;
                IP.KeepUnmatched = true;
                IP.addParameter('title','',@(x)ischar(x));
                IP.addParameter('xlabel','',@(x)ischar(x));
                IP.addParameter('ylabel','',@(x)ischar(x));
                IP.addParameter('grid','on',@(x)ischar(x));
                IP.parse(varargin{:});
                options = IP.Results;
                options.grid = validatestring(options.grid,{'on','off'});
            end 
        end
        
        function axishandle = legend(obj,id,varargin)
             
            % Gather options from input arguments
            [opts,varargin] = processInputs(varargin{:});
            
            legend(obj.axes(id),opts.list,varargin{:});
            axishandle = obj.axes(id);
            
            % EVALUATION INPUT ARGUMENTS
            function [options,unmatched] = processInputs(varargin) % nested function
                IP = inputParser;
                IP.KeepUnmatched = true;
                IP.addParameter('list',{},@(x)validateattributes(x,{'cell','char'},{'vector'}));
                IP.parse(varargin{:});
                options = IP.Results;
                unmatched = me.utils.namedargs2cell(IP.Unmatched);
            end 
        end
    end
    
    methods ( Access = protected )
        
        [id] = layoutwindow(obj,varargin);
        [num] = layoutfigure(obj,varargin);
        
        function axishandle = title(obj,id,str)
            if ~isempty(str)
                title(obj.axes(id),str);
            end
            axishandle = obj.axes(id);
        end
        
        function axishandle = xlabel(obj,id,str)
            if ~isempty(str)
                xlabel(obj.axes(id),str);
            end
            axishandle = obj.axes(id);
        end
        
        function axishandle = ylabel(obj,id,str)
            if ~isempty(str)
                ylabel(obj.axes(id),str);
            end
            axishandle = obj.axes(id);
        end
    end
    
    methods (Static)
        function demo()
            close all;
            % first figure
            obj = me.figure();
            obj.subplot(1,[0 1],[0 1],'k-.');
            obj.illustrate(1,'Title','First figure');
            % third figure
            obj = me.figure(3,...
                'Name','me. figure example',...
                'NumberTitle','off',...
                'Visible','off',...
                'Color','cyan',...
                'LayoutFigure',[2 1]);
            obj.subplot(1,[0 1],[1 0]);
            obj.illustrate(1,'Title','3rd, first subplot','YLabel','u [V]');
            obj.legend(1,'list',{'line_{a,b}'},'Interpreter','tex');
            % next subplot
            obj.subplot(2,[0 1],[0.8 0.8],'Color','black','LineWidth',2,'LineStyle',':','HandleVisibility','off');hold on;
            obj.subplot(2,[0 1],[0.6 1],'Color','red');
            obj.subplot(2,[0 1],[0.5 1],'Color','green');
            obj.subplot(2,[0 1],[0.4 1],'Color','blue');
            obj.illustrate(2,'Title','3rd, second subplot','YLabel','i [A]','XLabel','t [s]','grid','off');
            ahdl = obj.legend(2,'Location','northwest');
            colormap(ahdl,me.utils.stihl)
            obj.draw();
        end
        
    end
end

