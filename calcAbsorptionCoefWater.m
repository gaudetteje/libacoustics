function varargout = calcAbsorptionCoefWater(f,varargin)
% CALCABSORPTIONCOEFWATER
%   Returns the sound absorption coefficient in water (in dB/m)
%
% Input:
%   f   - frequency [Hz] - scalar or column vector
%   D   - depth [m]                         [default: 100]
%   T   - temperature [deg. C]              [default: 10]
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
%    Ainslie, M. A. & McColm, J. G. "A simplified formula for viscous and
%        chemical absorption in sea water." J. Acoust. Soc. Am. 103, 1671?1672.
%    Urick 1983 "Principles of underwater sound" 3rd Edition, Penninsula
%        Publishing, pg. 102-111
%    Fisher and Simmons 1977 "Sound absorption in sea water" J. Acoust.
%        Soc. Am. 62 (3)

% assign default values
D = 100;
T = 10;
S = 35;
pH = 8;

mode = 'fisher';  %'ainslie'

switch nargin
    case 5
        D = varargin{1};
        T = varargin{2};
        S = varargin{3};
        pH = varargin{4};
        warning('Salinity and pH do not have an effect on the calculation')
    case 4
        D = varargin{1};
        T = varargin{2};
        S = varargin{3};
        warning('Salinity and pH do not have an effect on the calculation')
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

switch mode
    case 'thorp'
        warning('This function computes alpha based on Thorp''s equation, which is only valid for T=4 degC, D=1 kyd.')
        % calculate absorption at zero depth (based on eq. by Thorp)
        % assumes temperature of 4 deg. C and depth of 3000 ft.
        alpha = (0.1 * f.^2)./(1 + f.^2) + (40 * f.^2)./(4100 + f.^2) + 2.75e-4 * f.^2 + 0.003;
        
        % convert to dB/m units from dB/ky
        alpha = alpha ./ 304.8;
        
    case 'fisher'
        % computation is based on pressure [atm]
        phi = 45;           % latitude [deg]
        P = 1;  %calcPressureFromDepth(D,phi);  % pressure [atm] at specified depth [m] and latitude [deg]
        
        % implement Fisher-Simmons 1977 equations
        A1 = (1.03e-8 + 2.36e-10 * T - 5.22e-12 * T.^2);
        A2 = (5.62e-8 + 7.52e-10 * T);
        A3 = (55.9 - 2.37 * T + 4.77e-2 * T.^2 - 3.48e-4 .* T.^3) .* 1e-15;
        
        f1 = 1.32e3 * (T + 273.1) * exp(-1700 / (T + 273.1));
        f2 = 1.55e7 * (T + 273.1) * exp(-3052 / (T + 273.1));
        
        P2 = 1 - 10.3e-4 * P + 3.7e-7;
        P3 = 1 - 3.84e-4 * P + 7.57e-8;
        
        % calculate absorption coefficient
        alpha = A1.*f1.*f.^2 ./ (f1.^2 + f.^2) + ...
            A2.*P2.*f2.*f.^2 ./ (f2.^2 + f.^2) + ...
            A3.*P3.*f.^2;
        
        % convert to dB/km units from m^-1
        alpha = alpha * 8686;
        
        % adjust for depth
        if D > 0
            % From Urick pg. 108
            Dhat = D * 3.2808399;       % convert depth in m to ft
            alpha = alpha * (1 - 1.93e-5*Dhat);
        end
        
    case 'ainslie'
        
        % frequency is in kHz
        f = f.*1e-3;
        
        
        % boron frequency constant
        f1 = 0.78 * (S./35)^0.5 .* exp(T./26);
        
        % magnesium frequency constant
        f2 = 42 * exp(T./17);
        
        % boron effect
        alpha1 = 0.106 * (f1 .* f.^2)./(f.^2 + f1.^2) * exp((pH - 8)./0.56);
        
        % magnesium effect
        alpha2 = 0.52 * (1 + T./43) .* (S./35) .* ((f2 .* f.^2)./(f.^2 + f2.^2)) .* exp(-D./6);
        
        % general low-pass effect
        alpha3 = 0.00049 * f.^2 .* exp(-(T./27 + D./17));
        
        % combined effects
        alpha = alpha1 + alpha2 + alpha3;
        
end



% generate plot if no output arguments present
if (length(f)>1 && nargout==0)
    loglog(f,alpha);
    grid on
    xlabel('Frequency/pressure (Hz)')
    %ylabel('Absorption coefficient \alpha (dB / m)')
    ylabel('Absorption coefficient \alpha (dB / km)')
    title(sprintf('Atmospheric absorption coef. (T=%.1fC, D=%.1fm, S=%.1fppt, pH=%.1f)',T,D,S,pH))
else
    varargout{1} = alpha;
end
