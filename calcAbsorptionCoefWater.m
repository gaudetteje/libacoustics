function varargout = calcAbsorptionCoefWater(f,varargin)
% CALCABSORPTIONCOEFWATER
%   Returns the sound absorption coefficient in water (in dB/m)
%
% Input:
%   f   - frequency [Hz] - scalar or column vector
%   D   - temperature [deg. C]              [default: 10]
%   T   - depth [m]                         [default: 100]
%   S   - salinity [ppt]                    [default: 35]
%   pH  - acidity [pH]                      [default: 8]
%
% Output:
%   alpha - absorption coefficient [dB/m]
%
% Note:
%   Frequency may be a scalar or vector
%

% NEED TO UPDATE DOCUMENTATION FOR WATER
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
%    Urick 1983 "Principles of underwater sound" 3rd Edition, Penninsula
%        Publishing, pg. 102-111
%    Thorp
%    Fletcher and Simmons

%    Bass et al 1995 "Atmospheric absorption of sound: Further developments" J.
%        Acoust. Soc. Am. 97 (1)
%    Bass et al 1990 "Atmospheric absorption of sound: Update" J. Acoust. Soc.
%        Am. 88 (4)
%    Benny et al 2000 "Beam profile measurements and simulations for ultrasonic
%        transducers operating in air" J. Acoust. Soc. Am. 107 (4)
%    ANSI S1.26-1995, "American National Standard Method for the Calculation of
%        the Absorption of Sound by the Atmosphere"
%    ISO 9613-1:1993, "Acoustics - Attenuation of sound during propagation
%        outdoors - Part 1: Calculation of the absorption of sound by the
%        atmosphere"
%

% assign default values
D = 100;
T = 10;
S = 35;
pH = 8;

warning('This function computes alpha based on Thorp''s equation, which is valid for T=4 degC, D=1 kyd.  Need to implement Fletcher and Simmons'' eqn.!')

switch nargin
    case 4
        D = varargin{1};
        T = varargin{2};
        S = varargin{3};
        pH = varargin{4};
    case 3
        D = varargin{1};
        T = varargin{2};
        S = varargin{3};
    case 3
        D = varargin{1};
        T = varargin{2};
    case 2
        D = varargin{1};
    case 1
    otherwise
        error('Incorrect number of parameters entered')
end


f = f(:);           % force frequency vector into column vector


% calculate absorption at zero depth (based on eq. by Thorp)
% assumes temperature of 4 deg. C and depth of 3000 ft.
alpha = (0.1 * f.^2)./(1 + f.^2) + (40 * f.^2)./(4100 + f.^2) + 2.75e-4 * f.^2 + 0.003;

% % adjust for depth
% if D > 0
%     Dhat = D * 3.2808399;       % convert depth in m to ft
%     alpha = alpha * (1 - 1.93e-5*Dhat);
% end
% 
% % convert to dB/m units from dB/ky
% alpha = alpha ./ 304.8;

% generate plot if no output arguments present
if (length(f)>1 && nargout==0)
    loglog(f,alpha);
    grid on
    xlabel('Frequency/pressure (Hz)')
    %ylabel('Absorption coefficient \alpha (dB / m)')
    ylabel('Absorption coefficient \alpha (dB / kyd)')
    title(sprintf('Atmospheric absorption coef. (T=%.1fC, D=%.1fm, S=%.1fppt, pH=%.1f)',T,D,S,pH))
else
    varargout{1} = alpha;
end
