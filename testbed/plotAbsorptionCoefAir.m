% This script plots the atmospheric absorption in air at different frequencies
% and % relative humidity at 20 degrees Celcius.  The plot should match Figure 1
% from Bass et. al. (1995)

clear
close all
clc


%% Vary absorption over humidity @ 20 degC
f = 10.^(3:0.01:6); % frequency points [Hz]
h_r = 0:10:100;         % relative humidity [%]
T = 20;                 % 20 degrees [celcius]

% calculate curves for each h
for i = 1:numel(h_r)
    [alpha, alpha_cr, alpha_vO, alpha_vN] = calcAbsorptionCoef(f,h_r(i),T);
    figure(1)
    loglog(f,alpha,'k')
    hold on;
    
    figure(2)
    loglog(f, alpha_cr, 'k')
    hold on;
    
    figure(3)
    loglog(f, alpha_vO, 'k')
    hold on;
    
    figure(4)
    loglog(f, alpha_vN, 'k')
    hold on;
end

% setup figure
figure(1)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Atmospheric absorption coef. (T=%.1fC, h_r=0-100%%)',T),'fontsize',14)
ylabel('Absorption Coefficient \alpha / \rho_s (dB / m\cdotatm)','fontsize',14)
xlabel('Frequency/pressure (Hz/atm)','fontsize',14)
set(gca,'fontsize',12)

figure(2)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to classical physics (T=%.1fC, h_r=0-100%%)',T),'fontsize',14)
ylabel('Absorption Coefficient \alpha_{cr} / \rho_s (dB / m\cdotatm)','fontsize',14)
xlabel('Frequency/pressure (Hz/atm)','fontsize',14)
set(gca,'fontsize',12)

figure(3)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to vibrational relaxation of Oxygen (T=%.1fC, h_r=0-100%%)',T),'fontsize',14)
ylabel('Absorption Coefficient \alpha_{vO} / \rho_s (dB / m\cdotatm)','fontsize',14)
xlabel('Frequency/pressure (Hz/atm)','fontsize',14)
set(gca,'fontsize',12)

figure(4)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to vibrational relaxation of Nitrogen (T=%.1fC, h_r=0-100%%)',T),'fontsize',14)
ylabel('Absorption Coefficient \alpha_{vN} / \rho_s (dB / m\cdotatm)','fontsize',14)
xlabel('Frequency/pressure (Hz/atm)','fontsize',14)
set(gca,'fontsize',12)

tilefigs(1:4,'keep')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vary absorption over temperature
f = 10.^(3:0.01:6); % frequency points [Hz]
h_r = 50;               % relative humidity [%]
T = 0:5:40;             % 20 degrees [celcius]
% Note:  Technically this varies h as well - molar concentration of water vapor

% calculate curves for each h
for i = 1:numel(T)
    [alpha, alpha_cr, alpha_vO, alpha_vN] = calcAbsorptionCoef(f,h_r,T(i));
    figure(5)
    loglog(f,alpha,'k')
    hold on;
    
    figure(6)
    loglog(f, alpha_cr, 'k')
    hold on;
    
    figure(7)
    loglog(f, alpha_vO, 'k')
    hold on;
    
    figure(8)
    loglog(f, alpha_vN, 'k')
    hold on;
end

% setup figure
figure(5)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Atmospheric absorption coef. (T=0-40C, h_r=%d%%)',h_r),'fontsize',14)
ylabel('Absorption Coefficient \alpha / \rho_s (dB / m\cdotatm)','fontsize',14)
xlabel('Frequency/pressure (Hz/atm)','fontsize',14)
set(gca,'fontsize',12)

figure(6)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to classical physics (T=0-40C, h_r=%d%%)',h_r),'fontsize',14)
ylabel('Absorption Coefficient \alpha_{cr} / \rho_s (dB / m\cdotatm)','fontsize',14)
xlabel('Frequency/pressure (Hz/atm)','fontsize',14)
set(gca,'fontsize',12)

figure(7)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to vibrational relaxation of Oxygen (T=0-40C, h_r=%d%%)',h_r),'fontsize',14)
ylabel('Absorption Coefficient \alpha_{vO} / \rho_s (dB / m\cdotatm)','fontsize',14)
xlabel('Frequency/pressure (Hz/atm)','fontsize',14)
set(gca,'fontsize',12)

figure(8)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to vibrational relaxation of Nitrogen (T=0-40C, h_r=%d%%)',h_r),'fontsize',14)
ylabel('Absorption Coefficient \alpha_{vN} / \rho_s (dB / m\cdotatm)','fontsize',14)
xlabel('Frequency/pressure (Hz/atm)','fontsize',14)
set(gca,'fontsize',12)

tilefigs(5:8,'keep')



%% Plot individual absorption components
f = 10.^(1:.01:6);
h_r = 50;               % 50% relative humidity [%]
T = 20;                 % 20 degrees [celcius]

[a1,acr,aO,aN] = calcAbsorptionCoef(f,h_r,T);
figure('color','white')
loglog(f,acr,'g',f,aO,'r',f,aN,'b',f,a1,'k');
legend('\alpha_{cr}','\alpha_{v,O}','\alpha_{v,N}','\alpha_{tot}','location','best')
grid on
title(sprintf('Components of absorption (T=%.1fC, h_r=%d%%)',T,h_r),'fontsize',14)
ylabel('Absorption Coefficient \alpha / \rho_s (dB / m\cdotatm)','fontsize',14);
xlabel('Frequency/pressure (Hz/atm)','fontsize',14);
set(gca,'fontsize',12)


%% Comparison with absorption coefficient table from ANSI standard
f = 10.^(1:.01:6);
h_r = (10:10:100);
T = 20;

% Calculate absorption coefficient across frequency for various humidity levels
for i=1:numel(h_r)
    calcAbsorptionCoef(f,h_r(i),T);
    hold on
end

% data copied from Table 1(j), pg. 9, of ANSI-ASA S1.26-1995 (R2009)
F = [50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000];
a10 = 1e-3 .* [0.270 0.370 0.487 0.622 0.776 0.965 1.22 1.58 2.12 2.95 4.25 6.26 9.36 14.1 21.1 31.3 45.3 63.5 85.4 109 133 156 175 193];
a20 = 1e-3 .* [0.174 0.260 0.377 0.529 0.712 0.919 1.14 1.39 1.69 2.06 2.60 3.39 4.62 6.53 9.53 14.2 21.5 32.6 49.4 74.1 109 156 215 284];
a30 = 1e-3 .* [0.125 0.192 0.290 0.429 0.615 0.848 1.12 1.42 1.75 2.10 2.52 3.06 3.84 5.00 6.81 9.63 14.1 21.0 31.8 48.5 73.8 112 166 242];
a40 = 1e-3 .* [0.0965 0.150 0.231 0.351 0.521 0.752 1.05 1.39 1.78 2.19 2.63 3.13 3.77 4.65 5.97 8.00 11.2 16.1 23.9 36.1 55.1 84.2 128 194];
a50 = 1e-3 .* [0.0784 0.123 0.191 0.294 0.445 0.660 0.950 1.32 1.75 2.23 2.73 3.27 3.89 4.66 5.75 7.37 9.85 13.7 19.8 29.4 44.4 67.8 104 159];
a60 = 1e-3 .* [0.066 0.104 0.162 0.252 0.386 0.582 0.858 1.23 1.68 2.21 2.79 3.40 4.05 4.80 5.78 7.17 9.25 12.5 17.5 25.4 37.9 57.4 87.8 135];
a70 = 1e-3 .* [0.057 0.0897 0.141 0.219 0.339 0.518 0.776 1.13 1.60 2.16 2.80 3.48 4.19 4.98 5.92 7.18 9.02 11.8 16.1 22.9 33.6 50.3 76.6 117];
a80 = 1e-3 .* [0.0501 0.0790 0.124 0.194 0.302 0.465 0.705 1.04 1.5 2.08 2.77 3.52 4.31 5.15 6.10 7.31 8.98 11.5 15.3 21.3 30.6 45.4 68.6 105];
a90 = 1e-3 .* [0.0447 0.0705 0.111 0.174 0.272 0.421 0.644 0.966 1.41 2.00 2.71 3.52 4.39 5.30 6.29 7.48 9.06 11.3 14.8 20.2 28.6 41.8 62.6 95.3];
a100 = 1e-3 .* [0.0403 0.0637 0.100 0.158 0.247 0.384 0.591 0.895 1.32 1.90 2.63 3.49 4.43 5.42 6.48 7.68 9.21 11.3 14.5 19.4 27.1 39.1 58.1 87.9];

loglog(F,[a10;a20;a30;a40;a50;a60;a70;a80;a90;a100],'r');
grid on
