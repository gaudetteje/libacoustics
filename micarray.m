classdef micarray
    %MICARRAY Microphone Array object
    %   This object defines a set of microphones in physical space and
    %   supports beamforming, localization, or other array functions.
    
    properties
        Pos    % 3D position of each array element [Nx3]
        NumCh  % total number of channels
        SerNo  % serial number of each microphone [Nx1]
        Units = 'm';    % unit of measure for coordinates
        c = 343;        % speed of sound [m/s]
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
        
        function zeta = steervec(obj, theta, phi)
            %STEERVEC Returns the unit steering vector from array center
            %   zeta = steervec(theta, phi) returns the 3D unit vector
            %   pointing toward azimuth, theta, and elevation, phi, in
            %   degrees

            zeta = [cosd(theta) sind(theta) sind(phi)];
            zNorm = vecnorm(zeta')' * ones(1,3);
            zeta = zeta ./ zNorm;
        end

        function alph = timedelay(obj, theta, phi)
            %TIMEDELAY Calculate time delay between elements
            %   alph = timedelay(theta,phi) returns the vector of time
            %   delays for a plane wave propagating from azimuth, theta,
            %   and elevation, phi, in degrees
            zeta = steervec(theta, phi);
            alph = zeta/obj.c * obj.Pos;
        end
    end
end
