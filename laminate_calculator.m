%This script serves for laminate calculation 
clc
clear all
close all

%% Input data
E1=20010000; 
E2=1301000;
G12=1001000;
v12=0.3;
angle=[45 0]; %stacking from bottom
t=[0.005 0.005]; %stacking from bottom

%% Lamina stiffness matrix Q and its transformation Q_bar (stiffness matrix of 1 ply)

Q_bar_laminate=zeros(3,3,length(angle)); %prepare 3D global laminate matrix

for i=1:length(angle) %numbering of matrices corresponds to numbering of plies from bottom
    Q_bar_laminate(:,:,i)=Q_bar(E1,E2,G12,v12,angle(1,i));
end
    
%% Global stiffness matrix, ABD matrix

%Calculation of total laminate thickness 't_tot'
t_tot=0;
for i=1:length(t)
    t_tot=t_tot+t(1,i);
end

% Calculation of length vector 'h' for A, B and D matrices (distance of plies with respect to laminate middle plane)
h=zeros(1,length(t)+1);
h(1,1)=-t_tot/2;
for i=1:length(t)
    h(1,i+1)=h(1,i)+t(1,i);
end

% A, B and D matrices
A=zeros(3);
B_temp=zeros(3);
D_temp=zeros(3);

for i=1:length(angle)
    A=A+Q_bar_laminate(:,:,i)*(h(1,i+1)-h(1,i));
    B_temp=B_temp+Q_bar_laminate(:,:,i)*(h(1,i+1)^2-h(1,i)^2);
    D_temp=D_temp+Q_bar_laminate(:,:,i)*(h(1,i+1)^3-h(1,i)^3);
end

B=B_temp*0.5;
D=D_temp/3;

ABD=[A B;B D];

%% Load vector F=[Nx Ny Nz Mx My Mz]

F=[250 0 0 0 0 0]';

%% Solve epsilon zero and k vector

Eps_K=ABD\F;

Eps0=[Eps_K(1,1);Eps_K(2,1);Eps_K(3,1)];
K=[Eps_K(4,1);Eps_K(5,1);Eps_K(6,1)];

%% Strain of each ply top and bottom in general coordinate system

Res_strain=zeros(2*length(angle),7); %ply top, bottom vs z, ex, ey, gxy, e1,e2,g12

Eps_xy=zeros(3,length(h));

for i=1:length(h)
    Eps_xy(:,i)=Eps0+h(1,i)*K; %column is border of plies, row is ex,ey,gxy
end


%% Strain of each ply top and bottom in material coordinate system (along fibres)

Eps_12=zeros(3,length(h));

for i=1:length(angle)
    T=transform(angle(1,i));
    for j=1:length(h)        
        Eps_12(:,j)=T*Eps_xy(:,j); %column is border of plies, row is ex,ey,gxy
    end
end

