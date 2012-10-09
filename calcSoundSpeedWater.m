function c = calcSoundSpeedWater(varargin)
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
%   This implementation is valid only for the following limits:
%      0 <= T <= 30
%      30 <= S <= 40
%      0 <= D <= 8000
%
% Default values:
%   T = 10 deg. C
%   S = 35 ppt
%   D = 100 m
%
% See:
%   Urick (1983) Principles of Underwater Sound, 3rd Edition, Peninsula
%     Publishing, Los Altos, CA, pp. 113
%   Mackenzie, K.V. (1981) Nine-term Equation for Sound Speed in the
%     Oceans, J. Acoust. Soc. Am., 70:807

% Default user parameters
T = 10;
S = 35;
D = 100;

switch(nargin)
    case 3
        D = varargin{3};
        S = varargin{2};
        T = varargin{1};
    case 2
        
        T = varargin{1};
    case 1
        T = varargin{1};
    case 0
    otherwise
        error('Incorrect number of user parameters')
end

% check input value range
if any(T < 0 | T > 30)
    warning('CALCSOUNDSPEED:Temp','Temperature out of valid range!')
end
if any(S < 30 | S > 40)
    warning('CALCSOUNDSPEED:Salinity','Salinity out of valid range!')
end
if any(D < 0 | D > 8000)
    warning('CALCSOUNDSPEED:Depth','Depth out of valid range!')
end

% compute the value(s)
c = 1448.96 + 4.591*T - 5.304e-3 * T.^2 ...
    + 2.374e-4 * T.^3 + 1.340 * (S - 35) ...
    + 1.630e-2 * D + 1.675e-7 * D.^2 ...
    - 1.025e-2 * T .* (S - 35) - 7.139e-13 * T .* D.^3;
