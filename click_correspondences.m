function [im1_pts, im2_pts] = click_correspondences(im1, im2)
% Author: Max Lu
% Date: 10/14/2016
%
% Inputs:   im1     rgb first image
%           im2     rgb second image   
% Outputs:  im1_pts     N*2 correspondences coordinates in first image
%           im2_pts     N*2 correspondences coordinates in second image
[im1_pts, im2_pts] = cpselect(im1,im2,'Wait',true);
