% This script plots the atmospheric absorption in air at different frequencies
% and % relative humidity at 20 degrees Celcius.  The plot should match Figure 1
% from Bass et. al. (1995)

clear
close all
clc

f = 10.^(3:0.01:6); % frequency points [Hz]


%% Vary absorption over humidity @ 20 degC
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
title(sprintf('Atmospheric absorption coef. (T=%.1fC, h_r=0-100%%)',T),'fontsize',12)
ylabel('Absorption Coefficient \alpha / \rho_s (dB / m\cdotatm)','fontsize',12)
xlabel('Frequency/pressure (Hz/atm)','fontsize',12)
set(gca,'fontsize',12)

figure(2)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to classical physics (T=%.1fC, h_r=0-100%%)',T),'fontsize',12)
ylabel('Absorption Coefficient \alpha_{cr} / \rho_s (dB / m\cdotatm)','fontsize',12)
xlabel('Frequency/pressure (Hz/atm)','fontsize',12)
set(gca,'fontsize',12)

figure(3)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to vibrational relaxation of Oxygen (T=%.1fC, h_r=0-100%%)',T),'fontsize',12)
ylabel('Absorption Coefficient \alpha_{vO} / \rho_s (dB / m\cdotatm)','fontsize',12)
xlabel('Frequency/pressure (Hz/atm)','fontsize',12)
set(gca,'fontsize',12)

figure(4)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to vibrational relaxation of Nitrogen (T=%.1fC, h_r=0-100%%)',T),'fontsize',12)
ylabel('Absorption Coefficient \alpha_{vN} / \rho_s (dB / m\cdotatm)','fontsize',12)
xlabel('Frequency/pressure (Hz/atm)','fontsize',12)
set(gca,'fontsize',12)

%tilefigs(1:4)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vary absorption over temperature
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
title(sprintf('Atmospheric absorption coef. (T=0-40C, h_r=%d%%)',h_r),'fontsize',12)
ylabel('Absorption Coefficient \alpha / \rho_s (dB / m\cdotatm)','fontsize',12)
xlabel('Frequency/pressure (Hz/atm)','fontsize',12)
set(gca,'fontsize',12)

figure(6)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to classical physics (T=0-40C, h_r=%d%%)',h_r),'fontsize',12)
ylabel('Absorption Coefficient \alpha_{cr} / \rho_s (dB / m\cdotatm)','fontsize',12)
xlabel('Frequency/pressure (Hz/atm)','fontsize',12)
set(gca,'fontsize',12)

figure(7)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to vibrational relaxation of Oxygen (T=0-40C, h_r=%d%%)',h_r),'fontsize',12)
ylabel('Absorption Coefficient \alpha_{vO} / \rho_s (dB / m\cdotatm)','fontsize',12)
xlabel('Frequency/pressure (Hz/atm)','fontsize',12)
set(gca,'fontsize',12)

figure(8)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to vibrational relaxation of Nitrogen (T=0-40C, h_r=%d%%)',h_r),'fontsize',12)
ylabel('Absorption Coefficient \alpha_{vN} / \rho_s (dB / m\cdotatm)','fontsize',12)
xlabel('Frequency/pressure (Hz/atm)','fontsize',12)
set(gca,'fontsize',12)
%tilefigs(5:8)



%% Plot individual absorption components
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
