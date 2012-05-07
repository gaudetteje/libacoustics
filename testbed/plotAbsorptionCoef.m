% This script plots the atmospheric absorption in air at different frequencies
% and % relative humidity at 20 degrees Celcius.  The plot should match Figure 1
% from Bass et. al. (1995)

clear
close all
clc


f = 10.^(1:0.01:6); % frequency points [Hz]
h = 0:10:100;       % relative humidity [%]
T = 20;             % 20 degrees [celcius]


% calculate curves for each h (note correction for dB/m*atm -> db/100m*atm)
for h_r = h
    [alpha, alpha_cr, alpha_vO, alpha_vN] = calcAbsorptionCoef(f,h_r,T);
    figure(1)
    loglog(f,1e2.*alpha,'k')
    hold on;
    
    figure(2)
    loglog(f, 8.686 * f.^2 .* (alpha_cr + alpha_vO'),'k')
    hold on;
    
    figure(3)
    loglog(f, 8.686 * f.^2 .* (alpha_cr + alpha_vN'),'k')
    hold on;
    
end

% setup figure
figure(1)
grid on;
axis([1e1 1e6 1e-3 1e4])
title('Sound Absorption Coefficient per atmosphere')
ylabel('Absorption Coefficient \alpha / \rho_s (dB / 100m\cdotatm)')
xlabel('Frequency/pressure (Hz/atm)')

figure(2)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title('Sound Absorption due to \alpha_{vO} per atmosphere')
ylabel('Absorption Coefficient \alpha_{vO} / \rho_s (dB / 100m\cdotatm)')
xlabel('Frequency/pressure (Hz/atm)')

figure(3)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title('Sound Absorption due to \alpha_{vN} per atmosphere')
ylabel('Absorption Coefficient \alpha_{vN} / \rho_s (dB / 100m\cdotatm)')
xlabel('Frequency/pressure (Hz/atm)')
