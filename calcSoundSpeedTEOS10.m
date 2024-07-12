function c = calcSoundSpeedTEOS10(varargin)
% calcSoundSpeedTEOS10  returns the speed of sound in water given
%   temperature, salinity, and depth using the Thermodynamic Equation of
%   Seawater (TEOS) 2010 standard
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
%   lat - latitude [deg N]
%   lon - longitude [deg E]
%
% Output:
%   c - speed of sound in water (m/s)

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
%   lat = 40 deg N
%   lon = 61 deg W
%
% See:
%   Urick (1983) Principles of Underwater Sound, 3rd Edition, Peninsula
%     Publishing, Los Altos, CA, pp. 113
%   TEOS-10

% Default user parameters
T = 10;
S = 35;
D = 100;
lat = 40;
lon = -61;

if nargin > 1
    T = varargin{1};
end
if nargin > 2
    S = varargin{2};
end
if nargin > 3
    D = varargin{3};
end
if nargin > 4
    lat = varargin{4};
end
if nargin > 5
    lon = varargin{5};
end

assert(all(lat >= -90) && all(lat <= 90));
assert(lon >= -180 && lon <= 360);

% % check input value range
% if any(T < 0 | T > 30)
%     warning('CALCSOUNDSPEED:Temp','Temperature out of valid range!')
% end
% if any(S < 30 | S > 40)
%     warning('CALCSOUNDSPEED:Salinity','Salinity out of valid range!')
% end
% if any(D < 0 | D > 8000)
%     warning('CALCSOUNDSPEED:Depth','Depth out of valid range!')
% end

%% compute the value(s)

% convert depth, D (i.e., negative height), to pressure, p [m to dbar]
p = gsw_p_from_z(-D,lat);

% convert SP to SA [relative to absolute salinity]
SA = gsw_SA_from_SP(S,p,lat,lon);

% convert T to CT [in-situ temperature to conservative temperature]
CT = gsw_CT_from_t(SA,T,p);

% use TEOS-10 with properly converted input units
c = gsw_sound_speed(SA,CT,p);
