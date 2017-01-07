

%% select correspondences
im1 = imread('jay500.jpg');
im2 = imread('me500.jpg');
load('pts_2', 'pts1', 'pts2');
%% find correspendences
% [pts1, pts2] = click_correspondences(im1, im2);
% %%
% pts1 = [pts1; 1,1;1,size(im1,2); size(im1,1),1; size(im1,1),size(im1,2)];
% pts2 = [pts2; 1,1;1,size(im2,2); size(im2,1),1; size(im2,1),size(im2,2)];
% %%
% pts1 = [pts1(:,2), pts1(:,1)];
% pts2 = [pts2(:,2), pts2(:,1)];
%%
tps = 0;

%%
if tps == 0
fname = 'Project2_trig.avi';
else 
fname = 'Project2_tps.avi';
end
try
    % VideoWriter based video creation
    h_avi = VideoWriter(fname, 'Uncompressed AVI');
    h_avi.FrameRate = 20;
    h_avi.open();
catch
    % Fallback deprecated avifile based video creation
    h_avi = avifile(fname,'fps',20);
end
for i = 1:60
    i
    w = double(i)/60;
    if tps == 1
        img_morphed = morph_tps_wrapper(im2, im1, pts2, pts1, w, w);
    else
        img_morphed = morph(im2, im1, pts2, pts1, w, w);
    end
    imagesc(img_morphed/255);axis image; axis off;drawnow;
    try
        % VideoWriter based video creation
        h_avi.writeVideo(getframe(gcf));
    catch
        % Fallback deprecated avifile based video creation
        h_avi = addframe(h_avi, getframe(gcf));
    end
end
try
    % VideoWriter based video creation
    h_avi.close();
catch
    % Fallback deprecated avifile based video creation
    h_avi = close(h_avi);
end
clear h_avi;