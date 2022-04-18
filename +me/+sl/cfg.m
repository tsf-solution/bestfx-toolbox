classdef cfg
    
    properties (Constant)
        meSimulinkLibraryLabel = 'Simulink Library .me';
        meSimulinkLibraryName = 'tsflib';
    end
    
    properties
        meSimulinkLibraryPath
        meSimulinkBlockIconPath
    end
    
    methods
        function obj = cfg()
            obj.meSimulinkLibraryPath = me.sl.cfg.getLibraryPath();
            obj.meSimulinkBlockIconPath = me.sl.cfg.getBlockIconPath();
        end
    end
    
    methods (Static, Access = private)
        function [str] = getFilePath()
            [str,~,~] = fileparts(mfilename('fullpath'));
        end
    end
    
    methods (Static)
        function [str] = getLibraryPath()
            cwd = pwd;
            str = cd(fullfile(me.sl.cfg.getFilePath(),'..','..'));
            cd(cwd);
        end
        
        function [str] = getBlockIconPath()
            str = fullfile(me.sl.cfg.getFilePath(),'@blockicon');
        end
    end
end

