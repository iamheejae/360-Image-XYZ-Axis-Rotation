clc; clear all
addpath('./function');

erp = imread('./erp.png'); 

[m, n, c] = size(erp);
erp_rot = zeros(size(erp));

rot_angle = 60;
rot_axis = 'Z';
for k=1:1:c    
    erp_rot(:,:,k) = rotate360(erp(:,:,k), rot_angle, rot_axis);
end

save_dir = sprintf('./erp_rot_about_%03d_degree_in_%s_axis.png', rot_angle, rot_axis);
imwrite(uint8(erp_rot), save_dir);
