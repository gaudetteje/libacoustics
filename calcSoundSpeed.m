function c = calcSoundSpeed(T)
% CALCSOUNDSPEED  returns the speed of sound given current temperature
%
% Input:
%   T - ambient temperature (degrees C)
%
% Output:
%   c - speed of sound in air (m/s)
%

c0  = 331.31;       % speed of sound at triple point of water
T01 = 273.16;       % triple-point isotherm temperature

c = c0 * sqrt((T+T01)/T01);
