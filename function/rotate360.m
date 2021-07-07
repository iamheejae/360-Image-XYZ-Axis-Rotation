function rotate_Y = rotate360(img, angle, Rot_axis)
%code is written as inverse mapping(to remove aliasing)...Put -x degree if you want to rotate about x degree

[H, W]=size(img);

rot_0=angle*pi/180;  %radian value
m2=0:W-1; %for inverse mapping
n2=0:H-1;                                     

mod_lng=(((m2+0.5)/W)-0.5)*2*pi; %phi
mod_lat=(0.5-((n2+0.5)/H))*pi; %theta 

XX=cos(mod_lat)'*cos(mod_lng); YY=-sin(mod_lat)'*ones(1,W); ZZ=-cos(mod_lat)'*sin(mod_lng);   
P=[XX(:)';YY(:)';ZZ(:)']; % 3x(heightxwidht)
R_x=[1,0,0; 0, cos(rot_0), -sin(rot_0); 0, sin(rot_0),cos(rot_0)];  %rotate P' points about theta
R_y=[cos(rot_0), 0, sin(rot_0); 0,1,0; -sin(rot_0), 0, cos(rot_0)];
R_z=[cos(rot_0), -sin(rot_0), 0;sin(rot_0),cos(rot_0),0 ;0,0,1]; 

if Rot_axis == 'X'
    rotate_P=R_x*P;
elseif Rot_axis == 'Y'
    rotate_P=R_y*P;
elseif Rot_axis=='Z'
    rotate_P=R_z*P;
end
X1=rotate_P(1,:); Y1=rotate_P(2,:); Z1=rotate_P(3,:); 
X=reshape(X1,H,W); Y=reshape(Y1,H,W); Z=reshape(Z1,H,W);

d=sqrt(Z.^2+X.^2+Y.^2); 
lat=asin(Y./d);
lng=atan2(-Z,X);

m1=round((0.5*lng/pi+0.5)*W-0.5)+1;   %%%%%round
n1=round((lat/pi+0.5)*H-0.5)+1;      %%%%%round      

rotate_Y=img(n1+(m1-1)*H);

rotate_Y=uint8(rotate_Y);
