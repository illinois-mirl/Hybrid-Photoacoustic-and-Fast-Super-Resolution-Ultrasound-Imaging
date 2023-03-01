%% spectrum unmixing 

A0 = inv(cal_use'*cal_use)*cal_use'; % cal_use is a matrix representing epsilon in the methods 

for kk = 1:size(PAimg_final1,3) 
    kk
     for i = 3-1:size(PAimg_final1,1)-2+1
            for j = 3-1:size(PAimg_final1,2)-2+1
                PA_use = squeeze(sum(sum(abs(PAimg_final1(i-1:i+1,j-1:j+1,kk,:)))));  % kk means pos
                PA_map(i,j,kk,:) = PA_use;
            end
     end
end


clear PA_column
for kk = 1:size(PAimg_final1,3) 
    for wl = 1:length(index_k)
        tmp = PA_map(:,:,kk,wl);  % wl means the number of wavelength used to do spectrum unmixing 
        PA_column(wl,:,kk) = tmp(:)';
    end
end

clear x12
for kk = 1:size(PAimg_final1,3) 
    tmp = A0*PA_column(:,:,kk);
    for ss = 1:2
        x12(:,:,kk,ss) = reshape(tmp(ss,:),size(PA_map,1),size(PA_map,2));
    end
    
end
