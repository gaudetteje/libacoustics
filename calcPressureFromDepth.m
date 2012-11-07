function P = calcPressureFromDepth(Z,varargin)
% CALCPRESSUREFROMDEPTH  computes the pressure based on depth under water
% and latitude
%
% 

phi = 45;       % assume a default of 45 degrees latitude
meth = 'leroy98';       % calculation method
ocean = 0;              % ocean corrective term


switch(meth)
    case 'leroy68'
        % convert depth [m] to pressure [kg/cm^2] - Leroy 1968
        h = 0.102506 * (1 + 5.28e-3 * sin(phi*pi/180)^2) * Z + 2.524e-7 * Z.^2;
        
    case 'leroy98'
        % convert depth [m] to pressure [MPa] - Leroy 1998
        g = 0.7803 * (1 + 5.3e-3 * sin(phi*pi/180)^2);
        k = (g - 2e-5 * Z) / (9.80612 - 2e-5 * Z);
        h45 = 1.00818e-2 .* Z + ...
              2.465e-8 .* Z.^2 - ...
              1.25e-13 .* Z.^3 + ...
              2.8e-19 .* Z.^4;
        h = h45 * k;
        
    otherwise
        error('Unknown method specified')
end

switch(ocean)
    case 0
        % common open ocean between 60 deg N and 40 deg S
%        dh = 0.8 * Z / (Z + 100) + 6.2e-6 * Z;
        dh = 1e-2 * Z / (Z + 100) + 6.2e-6 * Z;
        
    case 1
        % North Eastern Atlantic
        dh = 8e-3 * Z / (Z + 200) + 4e-6 * Z;
        
    case 2
        % Circumpolar Antarctic waters
        dh = 8e-3 * Z / (Z + 1000) + 1.6e-6 * Z;
        
    case 3
        % Mediterranean Sea
        dh = -8.5e-6 * Z + 1.4e-9 * Z.^2;
        
    case 4
        % Red Sea
        dh = 0;
        
    case 5
        % Arctic Ocean
        dh = 0;
        
    case 6
        % Sea of Japan
        dh = 7.8e-6 * Z;
        
    case 7
        % Sulu Sea
        dh = 1e-2 * Z / (Z + 100) + 1.6e-5 * Z + 1e-9 * Z.^2;
        
    case 8
        % Halmahera basin
        dh = 8e-3 * Z / (Z + 50) + 1.3e-5 * Z;
        
    case 9
        % Celebes basin / Weber deep
        dh = 1.2e-2 * Z / (Z + 100) + 7e-6 * Z + 2.5e-10 * Z.^2;
        
    case 10
        % Black Sea
        dh = 1.13e-4 * Z;
        
    case 11
        % Baltic Sea
        dh = 1.8e-4 * Z;
        
    otherwise
        error('Invalid ocean corrective term specified')
end

% Compute pressure [MPa] with corrective term
P = h - dh;

% convert from MPa to atm
P = P * 9.86923267;
