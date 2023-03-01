% localization using cross correlation
function mb_position = psfCC(data,psf,c_threshold,see_plot)

[psf_y_max,psf_x_max] = find(psf==max(max(psf)));
axis_length = size(data,1);
lateral_length = size(data,2);
frames = size(data,3); 
mb_position = zeros(100*frames,4);
mm = 1;

    for i = 1:frames
        img = abs(data(:,:,i));
        img(img<1e-2*max(img(:)))=1e-2*max(img(:)); % intensity threshold
        img = img - 1e-2*max(img(:));
        C = normxcorr2(psf,img);
        if see_plot == 1
            figure
            imagesc(C)
            colormap('jet')
            axis image
        end 
        C(C<c_threshold)=0; %% change threshold
        if see_plot == 1
            figure
            imagesc(C)
            colormap('jet')
            axis image
        end 

        BW_C = imregionalmax(C);
        
        if min(BW_C) == 0
%             [y_offset,x_offset] = find(BW_C~=0);
            % centroid detection
            [offset_pos,~] = centroid_dect_sim(C); % frames,x,y,intensity 
            y_offset = offset_pos(:,3);
            x_offset = offset_pos(:,2);
            correlation_ = offset_pos(:,4); %C(y_offset+(x_offset-1)*size(C,1))
             mb_position(mm:mm+length(y_offset)-1,:) = [i*ones(length(y_offset),1),correlation_,...
                 x_offset-size(psf,2)+psf_x_max,y_offset-size(psf,1)+psf_y_max]; % frame_num,correlation_index,y,x
             mm = mm+length(y_offset);
        end 
    end 

mb_position(find(mb_position(:,1)==0),:)=[];

end
