function c = calcSoundSpeedMedwin(varargin)
% calcSoundSpeedWater  returns the speed of sound in water given
%   temperature, salinity, and depth.
%
% c = calcSoundSpeedWater(T,S,D) calculates the sound speed in water for a
%   specified temperature, salinity, and depth.
% c = calcSoundSpeedWater(T,S) using the default depth
% c = calcSoundSpeedWater(T) using the default salinity and depth
% c = calcSoundSpeedWater returns the sound speed in water using all defaults
%
% Input:
%   T - temperature [degrees C]
%   S - salinity [parts per thousand (ppt)]
%   D - depth [m]
%
% Output:
%   c - speed of sound in water (m/s)
%
% Notes:
%   T, S, or D can be entered as an array for multiple vector calculations
%   This implementation is valid for the following range:
%      0 <= T <= 35
%      0 <= S <= 45
%      0 <= D <= 1000
%
% Default values:
%   T = 10 deg. C
%   S = 35 ppt
%   D = 100 m
%
% See:
%   Urick (1983) Principles of Underwater Sound, 3rd Edition, Peninsula
%     Publishing, Los Altos, CA, pp. 113
%   Medwin (1975) Speed of sound in water: A simple equation for realistic 
%     parameters, J. Acoust. Soc. Am., 58 (6), pp. 1318

% Default user parameters
T = 10;
S = 35;
D = 100;

% mode 

switch(nargin)
    case 3
        D = varargin{3};
        S = varargin{2};
        T = varargin{1};
    case 2
        S = varargin{2};
        T = varargin{1};
    case 1
        T = varargin{1};
    case 0
    otherwise
        error('Incorrect number of user parameters')
end

% check input value range
%if any(T < 0 | T > 35)
%    warning('CALCSOUNDSPEED:Temp','Temperature out of valid range!')
%end
%if any(S < 0 | S > 45)
%    warning('CALCSOUNDSPEED:Salinity','Salinity out of valid range!')
%end
%if any(D < 0 | D > 1000)
%    warning('CALCSOUNDSPEED:Depth','Depth out of valid range!')
%end

% compute the value(s)
c = 1449.2 + 4.6*T - 0.055*T.^2 + 0.00029*T.^3 + ...
    (1.34 - 0.01*T).*(S - 35) + 0.016*D;
