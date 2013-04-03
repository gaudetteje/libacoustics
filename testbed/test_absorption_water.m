
%close all
clear
clc
figure

set(gcf,'color','white')

% Calculate absorption coefficient across frequency for various
% temperatures
F = 10.^(3:.01:6);
T = (0:5:30);
for t=T
    calcAbsorptionCoefWater(F,100,t);
    hold on
end

grid on
set(gca,'fontsize',16)

oh = get(gca,'Title');
set(oh,'fontsize',16);
oh = get(gca,'XLabel');
set(oh,'fontsize',16);
oh = get(gca,'YLabel');
set(oh,'fontsize',16);

