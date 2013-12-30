function varargout = calcAbsorptionCoef(f,varargin)
% CALCABSORPTIONCOEF  Returns the sound absorption coefficient in air (in dB/m)
%
% Input:
%   f   - frequency dependence (Hz), scalar or column vector
%   h_r - relative humidity (%)               [default: 50]
%   T   - ambient temperature (degrees C)     [default: 20]
%   P   - atmospheric pressure (kPa)          [default: 101.325]
% Output:
%   alpha - absorption coefficient
%
% Note:
%   Frequency may be a scalar or vector
%
%
% Example 1:  Calculate the transmission loss of a pure 3kHz acoustic tone due
%   to atmospheric absorption and spherical spreading
%
%   To determine the acoustic
% transmission loss over a linear range, r, simply multiply the absorption
% coefficient, alpha, by the range, r.
%
%     TL_absorption = r * alpha
%
% Both r and alpha must use equal units of length measure (meters in this case).
%
%
%
% Example 2:  Simulate acoustic transmission loss due to both atmospheric
%   attenuation and spherical spreading
%
%
%
% Example 3:  Create an LTI filter that corrects for frequency-dependent
%   atmospheric absorption losses
%
%
%
% See following references for more info:
%    Bass et al 1995 "Atmospheric absorption of sound: Further developments"
%        J. Acoust. Soc. Am. 97 (1)
%    Bass et al 1990 "Atmospheric absorption of sound: Update" J. Acoust.
%        Soc. Am. 88 (4)
%    ANSI S1.26-1995, "American National Standard Method for the Calculation
%        of the Absorption of Sound by the Atmosphere"
%    ISO 9613-1:1993, "Acoustics - Attenuation of sound during propagation
%        outdoors - Part 1: Calculation of the absorption of sound by the
%        atmosphere"
%

% assign default values
h_r = 50;
T = 20;
P = 101.325;

switch nargin
    case 4
        h_r = varargin{1};
        T = varargin{2};
        P = varargin{3};
    case 3
        h_r = varargin{1};
        T = varargin{2};
    case 2
        h_r = varargin{1};
    case 1
    otherwise
        error('Incorrect number of parameters entered')
end


f = f(:);           % force frequency vector into column vector

%% step 0: define constants
P0  = 101.325;      % standard pressure (kPa)
T0  = 293.15;       % standard temperature (K)
T01 = 273.16;       % triple point of water (K)
T   = T01 + T;      % convert temperature to Kelven

%% step 1: calculate saturation vapor pressure ratio, P_sat/P0 (%)
P_sat = 10^(...
    10.79586 * (1-(T01/T)) - ...
    5.02808 * log10(T/T01) + ...
    1.50474e-4 * (1 - 10^(-8.29692*(T/T01-1))) + ...
    4.2873e-4 * (-1 + 10^(4.76955*(1-T01/T))) - ...
    2.2195983);

%% step 2: calculate molar concentration of water vapor, h (%)
h = h_r * P_sat * (P / P0)^-1;

%% step 3: calculate oxygen/nitrogen relaxation frequencies, f_rO & f_rN (Hz)
f_rO = (P/P0) * (24 + (4.04e4 * h * (0.02 + h)/(0.391 + h)));
f_rN = (P/P0) * (T/T0)^(-1/2) * (9 + 280 * h * exp(-4.17 * (T/T0)^(-1/3) - 1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% step 4: calculate dominant absorption components individually (nepers / m)
% alpha_cr = 1.84e-11 * (P/P0)^-1 * (T/T0)^(1/2);
% alpha_vO = 1.275e-2 * exp(-2239.1/T) .* (f_rO ./ (f_rO.^2 + f.^2));
% alpha_vN = 1.068e-1 * exp(-3352.0/T) .* (f_rN ./ (f_rN.^2 + f.^2));  % THIS TERM NEEDS TO BE LOOKED AT MORE CLOSELY - Rate shift due to alpha_vN occurs too low in frequency.  Not simply a function of f_rN.
% 
% % resulting attenuation coefficient is a linear addition (dB / m)
% alpha = 8.686 * f.^2 .* (alpha_cr + (T/T0)^(-5/2) .* (alpha_vO + alpha_vN));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% step 4: calculate dominant absorption components individually (dB / m)
% alpha_cr = 1.598e-10 * (P/P0)^-1 * (T/T0)^(1/2);
% alpha_vO = 1.107e-1 * exp(-2239.1/T) .* (T/T0)^(-5/2);
% alpha_vN = 9.277e-1 * exp(-3352.0/T) .* (T/T0)^(-5/2);  % THIS TERM NEEDS TO BE LOOKED AT MORE CLOSELY - Rate shift due to alpha_vN occurs too low in frequency.  Not simply a function of f_rN.
% 
% % resulting attenuation coefficient is a linear addition (dB / m)
% alpha = alpha_cr .* f.^2 + ...
%         alpha_vO .* (f.^2 .* f_rO) ./ (f_rO.^2 + f.^2) + ...
%         alpha_vN .* (f.^2 .* f_rN) ./ (f_rN.^2 + f.^2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% step 4: calculate dominant absorption components individually (dB / m)
alpha_cr = 1.598e-10 * (P/P0)^-1 * (T/T0)^(1/2) .* f.^2;
alpha_vO = 1.107e-1 * exp(-2239.1/T) .* (T/T0)^(-5/2) .* (f.^2 .* f_rO) ./ (f_rO.^2 + f.^2);
alpha_vN = 9.277e-1 * exp(-3352.0/T) .* (T/T0)^(-5/2) .* (f.^2 .* f_rN) ./ (f_rN.^2 + f.^2);  % THIS TERM NEEDS TO BE LOOKED AT MORE CLOSELY - Rate shift due to alpha_vN occurs too low in frequency.  Not simply a function of f_rN.

% resulting attenuation coefficient is a linear addition (dB / m)
alpha = alpha_cr + alpha_vO + alpha_vN;

% generate plot if no output arguments present
if (length(f)>1 && nargout==0)
    loglog(f,alpha);
    grid on
    xlabel('Frequency/pressure (Hz / atm)')
    ylabel('Absorption coefficient \alpha/p_s (dB / m atm)')
    title(sprintf('Atmospheric absorption coef. (T=%.1fC, h_{rel}=%d%%, P_{amb}=%.3fkPa)',T-T01,h_r,P))
else
    varargout{1} = alpha;
    varargout{2} = alpha_cr;
    varargout{3} = alpha_vO;
    varargout{4} = alpha_vN;
end
