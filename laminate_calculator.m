%% This script serves for laminate calculation

clc
clear all
close all

%% Input data
E1=57450;
E2=57450;
G12=2630;
v12=0.037;
angle=[0 45 0 0 45 0 0 45 0]; %stacking from bottom
t=[0.22 0.22 0.22 0.22 0.22 0.22 0.22 0.22 0.22]; %stacking from bottom

%% Load vector F=[Nx Ny Nz Mx My Mz]

F=[90.93 0 0 0 0 0]';

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

%% Solve epsilon zero and k vector

Eps_K=ABD\F;

Eps0=[Eps_K(1,1);Eps_K(2,1);Eps_K(3,1)];
K=[Eps_K(4,1);Eps_K(5,1);Eps_K(6,1)];

%% Ply boundary coordinate matrix 'z'
% matrix containing coordiantes of plies boundaries (no. ply vs bottom, top)

z=zeros(length(angle),2); 
j=1;
while j<=length(angle)
    z(j,1)=h(1,j);
    z(j,2)=h(1,j+1);
    j=j+1;
end

%% Strain at bottom and top of each ply in general coordinate system (panel coordinate system)

Eps_xy=zeros(3,2,length(angle)); 

for i=1:length(angle)
    for j=1:2
        Eps_xy(:,j,i)=Eps0+z(i,j)*K; %3d matrix with engineering shear strain, general strain for top, bottom of each ply
    end
end

Eps_xy_tens=Eps_xy;

% loop to convert engineering strain to tensorial shear strain (important for further transposition to material coordinate system)
%tensorial shear strain epsilon_xy=gama_xy/2, half of engineering shear strain

for i=1:length(angle) 
    for j=1:2
        Eps_xy_tens(3,j,i)=Eps_xy_tens(3,j,i)/2;
    end
end

%% Strain at bottom and top of each ply in material coordinate system (along fibres of a particular ply)

Eps_12=zeros(3,2,length(angle));

for i=1:length(angle)
    if angle(1,i)==0
        for j=1:2      
            Eps_12(:,j,i)=Eps_xy_tens(:,j,i); 
        end
    else
    T=transform(angle(1,i));
        for j=1:2      
            Eps_12(:,j,i)=T*Eps_xy_tens(:,j,i); 
        end
    end
end

% loop to convert tensorial shear strain 'epsilon_12' to engineering shear strain 'gama_12'

for i=1:length(angle) 
    for j=1:2
        Eps_12(3,j,i)=Eps_12(3,j,i)*2; %3d material strain matrix with ENGINEERING shear strain 'gama_12'  
    end
end

%% Stress at bottom and top of each ply in general coordinate system (panel coordinate system)

Sig_xy=zeros(3,2,length(angle)); 

for i=1:length(angle)
    for j=1:2
        Sig_xy(:,j,i)=Q_bar_laminate(:,:,i)*Eps_xy(:,j,i); %3d matrix with stress, sig x, sig y, tau xy vs bottom, top vs ply
    end
end

%% Stress at bottom and top of each ply in material coordinate system (along fibres of a particular ply)

Sig_12=zeros(3,2,length(angle));

for i=1:length(angle)
    if angle(1,i)==0
        for j=1:2      
            Sig_12(:,j,i)=Sig_xy(:,j,i); 
        end
    else
    T=transform(angle(1,i));
        for j=1:2      
            Sig_12(:,j,i)=T*Sig_xy(:,j,i); 
        end
    end
end


