%% INITIALIZE
do_trig = 0;
% img = (imread('project2_testimg.png'));
img = (imread('trump512.jpg'));
% Control points
p1 = [1 1; 257 1; 1 257; 257 257; 129 129];
p2(1) = {[1 1; 257 1; 1 257; 257 257; 129 33]};
p2(2) = {[1 1; 257 1; 1 257; 257 257; 33 129]};
p2(3) = {[1 1; 257 1; 1 257; 257 257; 129 223]};
p2(4) = {[1 1; 257 1; 1 257; 257 257; 223 129]};
p2(5) = {cell2mat(p2(1))};

% Figure 
h = figure(2); clf;
whitebg(h,[0 0 0]);


%% EVAL
tic
if do_trig
    fname = 'Project2_eval_trig.avi';
else
    fname = 'Project2_eval_tps.avi';
end
try
    % VideoWriter based video creation
    h_avi = VideoWriter(fname, 'Uncompressed AVI');
    h_avi.FrameRate = 10;
    h_avi.open();
catch
    % Fallback deprecated avifile based video creation
    h_avi = avifile(fname,'fps',10);
end

% Warp reference images
if (do_trig)
  img_ref(1) = {morph(img, img, p1, cell2mat(p2(1)), 1, 0)};
  img_ref(2) = {morph(img, img, p1, cell2mat(p2(2)), 1, 0)};
  img_ref(3) = {morph(img, img, p1, cell2mat(p2(3)), 1, 0)};
  img_ref(4) = {morph(img, img, p1, cell2mat(p2(4)), 1, 0)};
  img_ref(5) = {cell2mat(img_ref(1))};
else
  img_ref(1) = {morph_tps_wrapper(img, img, p1, cell2mat(p2(1)), 1, 0)};
  img_ref(2) = {morph_tps_wrapper(img, img, p1, cell2mat(p2(2)), 1, 0)};
  img_ref(3) = {morph_tps_wrapper(img, img, p1, cell2mat(p2(3)), 1, 0)};
  img_ref(4) = {morph_tps_wrapper(img, img, p1, cell2mat(p2(4)), 1, 0)};
  img_ref(5) = {cell2mat(img_ref(1))};
end  

% Morph iteration
for j=1:4
  for w=0:0.1:1
    img_source = cell2mat(img_ref(j));
    p_source = cell2mat(p2(j));
    img_dest = cell2mat(img_ref(j+1));
    p_dest = cell2mat(p2(j+1));
    if (do_trig == 0)
      img_morphed = morph_tps_wrapper(img_source, img_dest, p_source, p_dest, w, w);
    else
      img_morphed = morph(img_source, img_dest, p_source, p_dest, w, w);
    end
    % if image type is double, modify the following line accordingly if necessary
    imagesc(img_morphed);
    axis image; axis off;drawnow;
    try
        % VideoWriter based video creation
        h_avi.writeVideo(getframe(gcf));
    catch
        % Fallback deprecated avifile based video creation
        h_avi = addframe(h_avi, getframe(gcf));
    end
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
toc