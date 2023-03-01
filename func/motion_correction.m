%% motion correction 

clear all
close all
% ref_IQ0 = abs(IQ3(:,:,200));  

%% Correlation to remove breathe motion
i = 1;
load(['IQ_Buffer_',num2str(i,'%.5d'),'.mat'])
IQ3 = squeeze(complex(IData{1}(:,:,:,:,:),QData{1}(:,:,:,:,:)));

for ii = 1:400
    CorrCoeff(ii) = corr2(abs(IQ3(:,:,ii)),ref_IQ0);
end 

save(['motion_corr',num2str(i),'.mat'],'CorrCoeff');
    

%     figure
%     plot(CorrCoeff ,'LineWidth',2)
%     xlabel('Frame num')
%     ylabel('correlation coeff')
%     set(gca,'FontSize',16)
%     grid on

%% image transformation to correct motion 

[optimizer,metric] = imregconfig('monomodal');
clear tform_final
 
parfor ii = 1:size(IQ,3)
    ii
    tform = imregtform(abs(IQ3(:,:,ii)),ref_IQ0,'rigid',optimizer,metric);
    tform_final(:,:,ii) = tform.T;  % 
    theta(ii) = acos(tform.T(1,1))/pi*180;
    X(ii) = tform.T(3,1);
    Z(ii) = tform.T(3,2);
    IQ_correct(:,:,ii) = imwarp(IQ3(:,:,ii),tform,'OutputView',imref2d([size(IQ3,1),size(IQ3,2)]));
end
    
save(['motion_correct_',num2str(i),'.mat'], 'tform_final','ref_IQ0')
