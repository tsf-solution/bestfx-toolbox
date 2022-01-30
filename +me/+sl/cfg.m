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
    
    methods (Static)
        function [str] = getLibraryPath()
            [str,~,~] = fileparts(mfilename('fullpath'));
        end
        
        function [str] = getBlockIconPath()
            str = fullfile(me.sl.cfg.getLibraryPath(),'@blockicon');
        end
    end
end

