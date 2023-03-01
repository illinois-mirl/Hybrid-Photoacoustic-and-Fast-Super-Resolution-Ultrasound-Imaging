%% measure the resolution

% FSC are Matlab function downloaded from:
% https://github.com/bionanoimaging/cellSTORM-MATLAB/blob/master/Functions/FSC.m

SoS = 1.54; % mm/s
f0 = 15; % MHz
pixel_res = SoS/f0/8; %mm
p.beta = 1
frc = FSC(im1, im2, p);  
figure
hold on
plot(frc.nu*1/(pixel_res)/1000, frc.frc, 'DisplayName', 'FRC','LineWidth',2)
plot(frc.nu*1/(pixel_res)/1000, frc.T_hbit, 'DisplayName', '1/2 bit Threshold','LineWidth',2)
plot(frc.nu*1/(pixel_res)/1000, frc.T_bit, 'DisplayName', '1 bit Threshold','LineWidth',2)
xlabel ('um^{-1}')
ylabel('FRC')
hold off
legend show
set(gca,'FontSize',16)


