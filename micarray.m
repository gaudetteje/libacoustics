classdef micarray
    %MICARRAY Microphone Array object
    %   This object defines a set of microphones in physical space and
    %   supports beamforming, localization, or other array functions.
    
    properties
        Pos    % 3D position of each array element [Nx3]
        NumCh  % total number of channels
        SerNo  % serial number of each microphone [Nx1]
        Units  % unit of measure for coordinates
    end
    
    methods
        function obj = micarray(x,y,z)
            %MICARRAY Create a microphone array object
            %   Constructor takes the x, y, and z coordinates as vectors of
            %   equal size
            obj.Pos = [x(:), y(:), z(:)];
            obj.NumCh = size(obj.Pos,1);
        end
        
        function plot(obj)
            %PLOT Plot array coordinates
            plot3(obj.Pos(:,1),obj.Pos(:,2),obj.Pos(:,3),'.','MarkerSize',20);
        end
    end
end
