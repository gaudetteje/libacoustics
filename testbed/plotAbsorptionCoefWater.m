% This script plots the absorption coefficient for water at different
% frequencies and environmental parameters

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vary absorption over depth
clear
close all
clc

f = 10.^(3:0.01:6);     % frequency points [Hz]
D = (0:10:100);         % depth [m]
T = 10;                 % temperature [deg C]
S = 35;                 % salinity [ppt]
pH = 8;                 % acidity [pH]

% calculate curves for each D
for i = 1:numel(D)
    [alpha, alpha_cr, alpha_vB, alpha_vM] = calcAbsorptionCoefWater(f,D(i),T,S,pH);
    figure(1)
    loglog(f,alpha,'k')
    hold on;
    
    figure(2)
    loglog(f, alpha_cr, 'k')
    hold on;
    
    figure(3)
    loglog(f, alpha_vB, 'k')
    hold on;
    
    figure(4)
    loglog(f, alpha_vM, 'k')
    hold on;
end

% setup figure
figure(1)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Atmospheric absorption coef. (T=%g%sC, D=%g-%gm, S=%gppt, pH=%g)',T,'\circ',D(1),D(end),S,pH),'fontsize',14)
ylabel('Absorption Coefficient \alpha (dB / km)','fontsize',14)
xlabel('Frequency (Hz)','fontsize',14)
set(gca,'fontsize',12)

figure(2)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to classical physics (T=%g%sC, D=%g-%gmm, S=%gppt, pH=%g)',T,'\circ',D(1),D(end),S,pH),'fontsize',14)
ylabel('Absorption Coefficient \alpha_{cr} (dB / km)','fontsize',14)
xlabel('Frequency (Hz)','fontsize',14)
set(gca,'fontsize',12)

figure(3)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to vibrational relaxation of Boric Acid (T=%g%sC, D=%g-%gmm, S=%gppt, pH=%g)',T,'\circ',D(1),D(end),S,pH),'fontsize',14)
ylabel('Absorption Coefficient \alpha_{vB} (dB / km)','fontsize',14)
xlabel('Frequency (Hz)','fontsize',14)
set(gca,'fontsize',12)

figure(4)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to vibrational relaxation of Magnesium Sulfate (T=%g%sC, D=%g-%gmm, S=%gppt, pH=%g)',T,'\circ',D(1),D(end),S,pH),'fontsize',14)
ylabel('Absorption Coefficient \alpha_{vM} (dB / km)','fontsize',14)
xlabel('Frequency (Hz)','fontsize',14)
set(gca,'fontsize',12)

tilefigs(1:4,'keep')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vary absorption over temperature
clear
close all
clc

f = 10.^(3:0.01:6);     % frequency points [Hz]
D = 0;                  % depth [m]
T = (-5:5:35);          % temperature [deg C]
S = 35;                 % salinity [ppt]
pH = 8;                 % acidity [pH]

% calculate curves for each T
for i = 1:numel(T)
    [alpha, alpha_cr, alpha_vB, alpha_vM] = calcAbsorptionCoefWater(f,D,T(i),S,pH);
    figure(1)
    loglog(f,alpha,'k')
    hold on;
    
    figure(2)
    loglog(f, alpha_cr, 'k')
    hold on;
    
    figure(3)
    loglog(f, alpha_vB, 'k')
    hold on;
    
    figure(4)
    loglog(f, alpha_vM, 'k')
    hold on;
end

% setup figure
figure(1)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Atmospheric absorption coef. (T=%g-%g%sC, D=%gm, S=%gppt, pH=%g)',T(1),T(end),'\circ',D,S,pH),'fontsize',14)
ylabel('Absorption Coefficient \alpha (dB / km)','fontsize',14)
xlabel('Frequency (Hz)','fontsize',14)
set(gca,'fontsize',12)

figure(2)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to classical physics (T=%g-%g%sC, D=%gm, S=%gppt, pH=%g)',T(1),T(end),'\circ',D,S,pH),'fontsize',14)
ylabel('Absorption Coefficient \alpha_{cr} (dB / km)','fontsize',14)
xlabel('Frequency (Hz)','fontsize',14)
set(gca,'fontsize',12)

figure(3)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to vibrational relaxation of Boric Acid (T=%g-%g%sC, D=%gm, S=%gppt, pH=%g)',T(1),T(end),'\circ',D,S,pH),'fontsize',14)
ylabel('Absorption Coefficient \alpha_{vB} (dB / km)','fontsize',14)
xlabel('Frequency (Hz)','fontsize',14)
set(gca,'fontsize',12)

figure(4)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to vibrational relaxation of Magnesium Sulfate (T=%g-%g%sC, D=%gm, S=%gppt, pH=%g)',T(1),T(end),'\circ',D,S,pH),'fontsize',14)
ylabel('Absorption Coefficient \alpha_{vM} (dB / km)','fontsize',14)
xlabel('Frequency (Hz)','fontsize',14)
set(gca,'fontsize',12)

tilefigs(1:4,'keep')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vary absorption over salinity
clear
close all
clc

f = 10.^(3:0.01:6);     % frequency points [Hz]
D = 0;                  % depth [m]
T = 10;                 % temperature [deg C]
S = 5:5:50;             % salinity [ppt]
pH = 8;                 % acidity [pH]

% calculate curves for each S
for i = 1:numel(S)
    [alpha, alpha_cr, alpha_vB, alpha_vM] = calcAbsorptionCoefWater(f,D,T,S(i),pH);
    figure(1)
    loglog(f,alpha,'k')
    hold on;
    
    figure(2)
    loglog(f, alpha_cr, 'k')
    hold on;
    
    figure(3)
    loglog(f, alpha_vB, 'k')
    hold on;
    
    figure(4)
    loglog(f, alpha_vM, 'k')
    hold on;
end

% setup figure
figure(1)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Atmospheric absorption coef. (T=%g%sC, D=%gm, S=%g-%gppt, pH=%g)',T,'\circ',D,S(1),S(end),pH),'fontsize',14)
ylabel('Absorption Coefficient \alpha (dB / km)','fontsize',14)
xlabel('Frequency (Hz)','fontsize',14)
set(gca,'fontsize',12)

figure(2)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to classical physics (T=%g%sC, D=%gm, S=%g-%gppt, pH=%g)',T,'\circ',D,S(1),S(end),pH),'fontsize',14)
ylabel('Absorption Coefficient \alpha_{cr} (dB / km)','fontsize',14)
xlabel('Frequency (Hz)','fontsize',14)
set(gca,'fontsize',12)

figure(3)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to vibrational relaxation of Boric Acid (T=%g%sC, D=%gm, S=%g-%gppt, pH=%g)',T,'\circ',D,S(1),S(end),pH),'fontsize',14)
ylabel('Absorption Coefficient \alpha_{vB} (dB / km)','fontsize',14)
xlabel('Frequency (Hz)','fontsize',14)
set(gca,'fontsize',12)

figure(4)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to vibrational relaxation of Magnesium Sulfate (T=%g%sC, D=%gm, S=%g-%gppt, pH=%g)',T,'\circ',D,S(1),S(end),pH),'fontsize',14)
ylabel('Absorption Coefficient \alpha_{vM} (dB / km)','fontsize',14)
xlabel('Frequency (Hz)','fontsize',14)
set(gca,'fontsize',12)

tilefigs(1:4,'keep')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vary absorption over pH
clear
close all
clc

f = 10.^(3:0.01:6);     % frequency points [Hz]
D = 0;                  % depth [m]
T = 10;                 % temperature [deg C]
S = 35;                 % salinity [ppt]
pH = (7.8:0.1:8.2);     % acidity [pH]

% calculate curves for each pH
for i = 1:numel(pH)
    [alpha, alpha_cr, alpha_vB, alpha_vM] = calcAbsorptionCoefWater(f,D,T,S,pH(i));
    figure(1)
    loglog(f,alpha,'k')
    hold on;
    
    figure(2)
    loglog(f, alpha_cr, 'k')
    hold on;
    
    figure(3)
    loglog(f, alpha_vB, 'k')
    hold on;
    
    figure(4)
    loglog(f, alpha_vM, 'k')
    hold on;
end

% setup figure
figure(1)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Atmospheric absorption coef. (T=%g%sC, D=%gm, S=%gppt, pH=%g-%g)',T,'\circ',D,S,pH(1),pH(end)),'fontsize',14)
ylabel('Absorption Coefficient \alpha (dB / km)','fontsize',14)
xlabel('Frequency (Hz)','fontsize',14)
set(gca,'fontsize',12)

figure(2)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to classical physics (T=%g%sC, D=%gm, S=%gppt, pH=%g-%g)',T,'\circ',D,S,pH(1),pH(end)),'fontsize',14)
ylabel('Absorption Coefficient \alpha_{cr} (dB / km)','fontsize',14)
xlabel('Frequency (Hz)','fontsize',14)
set(gca,'fontsize',12)

figure(3)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to vibrational relaxation of Boric Acid (T=%g%sC, D=%gm, S=%gppt, pH=%g-%g)',T,'\circ',D,S,pH(1),pH(end)),'fontsize',14)
ylabel('Absorption Coefficient \alpha_{vB} (dB / km)','fontsize',14)
xlabel('Frequency (Hz)','fontsize',14)
set(gca,'fontsize',12)

figure(4)
grid on;
%axis([1e1 1e6 1e-3 1e4])
title(sprintf('Absorption due to vibrational relaxation of Magnesium Sulfate (T=%g%sC, D=%gm, S=%gppt, pH=%g-%g)',T,'\circ',D,S,pH(1),pH(end)),'fontsize',14)
ylabel('Absorption Coefficient \alpha_{vM} (dB / km)','fontsize',14)
xlabel('Frequency (Hz)','fontsize',14)
set(gca,'fontsize',12)

tilefigs(1:4,'keep')


%% Plot individual absorption components
f = 10.^(2:0.01:6); % frequency points [Hz]
D = 0;                  % depth [m]
T = -1.5;               % temperature [deg C]
S = 30;                 % salinity [ppt]
pH = 8.2;               % acidity [pH]

[atot,acr,aB,aM] = calcAbsorptionCoefWater(f,D,T,S,pH);
figure('color','white')
loglog(f,acr,'g',f,aB,'r',f,aM,'b',f,atot,'k');
legend('\alpha_{cr}','\alpha_{v,B}','\alpha_{v,M}','\alpha_{tot}','location','best')
grid on
title(sprintf('Components of absorption (T=%g%sC, D=%gm, S=%gppt, pH=%g)',T,'\circ',D,S,pH),'fontsize',14)
ylabel('Absorption Coefficient \alpha / \rho_s (dB / km\cdotatm)','fontsize',14);
xlabel('Frequency/pressure (Hz/atm)','fontsize',14);
set(gca,'fontsize',12)
