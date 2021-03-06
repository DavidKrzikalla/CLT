%% This script serves for calculation of stress and strain within a laminate plate
% Author: David Krzikalla

% Classical Laminate Theory used
% Source of theory:
% - Nettles, A.T., 1994. Basic mechanics of laminated composite plates. (NASA) 
% - add sources for criterions

% Before making any conclusion, firstly get familiar with aspects of
% failure criterions

% Take this results as preliminary and for information only
% Thorough analysis should be performed using FEM before manufacturing

%% Initiation phase

clc
clear all
close all

wb=waitbar(0,'Calculation in progress...');
set(wb,'Name','Laminate Calculator');
wbObject=findobj(wb,'Type','Patch');
set(wbObject,'FaceColor',[0 1 0]);
waitbar(.1);
%% Input data
%Material data for each ply are imported from Excel sheet 

material_import = xlsread('laminate_calc_theory_material_data.xlsx','Stacking_sequence','D5:M15');

[angle,E1,E2,G12,v12,sig_tL,sig_cL,sig_tT,sig_cT,tau_TL,t]=plies_material(material_import);

%% Load vector F=[Nx Ny Nz Mx My Mz]' [N/mm, N/mm*mm]
%!!! Before load input, see Excel spreadsheet for info!!!

F=[182.66 0 0 0 0 0]';

%% Lamina stiffness matrix Q and its transformation Q_bar (stiffness matrix of 1 ply)

Q_bar_laminate=zeros(3,3,length(angle)); %prepare 3D global laminate matrix

for i=1:length(angle) %numbering of matrices corresponds to numbering of plies from bottom
    Q_bar_laminate(:,:,i)=Q_bar(E1(1,i),E2(1,i),G12(1,i),v12(1,i),angle(1,i));
end
    
waitbar(.3);
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

waitbar(.5);
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
    Strain_table=transform(angle(1,i));
        for j=1:2      
            Eps_12(:,j,i)=Strain_table*Eps_xy_tens(:,j,i); 
        end
    end
end

% loop to convert tensorial shear strain 'epsilon_12' to engineering shear strain 'gama_12'

for i=1:length(angle) 
    for j=1:2
        Eps_12(3,j,i)=Eps_12(3,j,i)*2; %3d material strain matrix with ENGINEERING shear strain 'gama_12'  
    end
end

waitbar(.7);
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
    Strain_table=transform(angle(1,i));
        for j=1:2      
            Sig_12(:,j,i)=Strain_table*Sig_xy(:,j,i); 
        end
    end
end

waitbar(.8);
%% Summary tables

[Eps_res, Sig_res,Z_coor]=results_table(Eps_xy,Eps_12,Sig_xy,Sig_12,z,angle);

Strain_table=table(Eps_res(:,1),Eps_res(:,2),Eps_res(:,3),Eps_res(:,4),Eps_res(:,5),Eps_res(:,6),Eps_res(:,7),Eps_res(:,8));
Strain_table.Properties.VariableNames = {'Ply_No' 'Z_coordinate' 'E_x' 'E_y' 'Gama_xy' 'E_1' 'E_2' 'Gama_12'};
disp(Strain_table);

Stress_table=table(Sig_res(:,1),Sig_res(:,2),Sig_res(:,3),Sig_res(:,4),Sig_res(:,5),Sig_res(:,6),Sig_res(:,7),Sig_res(:,8));
Stress_table.Properties.VariableNames = {'Ply_No' 'Z_coordinate' 'S_x' 'S_y' 'Tau_xy' 'S_1' 'S_2' 'Tau_12'};
disp(Stress_table);

%% Plotting

plotting(Eps_res,Sig_res, Z_coor,h)

waitbar(.9);
%% Failure criterions
% Values of RFs should be higher than 1 for each criterion

% Max stress criterion
RF_max_stress=max_stress_criterion(Sig_12,sig_tL,sig_cL,sig_tT,sig_cT,tau_TL);

% Tsai-Hill criterion
RF_tsai_hill=tsai_hill(Sig_12,sig_tL,sig_tT,sig_cL,sig_cT,tau_TL);

% Hoffman criterion
RF_hoffman=hoffman(Sig_12,sig_tL,sig_tT,sig_cL,sig_cT,tau_TL);

Ply_no=zeros(length(angle),1);
j=1;
for i=size(RF_hoffman,1):-1:1
    Ply_no(i,1)=j;
    j=j+1;
end

waitbar(1);

RF_res=[Ply_no RF_max_stress RF_tsai_hill RF_hoffman];

RF_table=table(RF_res(:,1),RF_res(:,2),RF_res(:,3),RF_res(:,4));
RF_table.Properties.VariableNames = {'Ply_No' 'Max_stress' 'Tsai_Hill' 'Hoffman'};
disp(RF_table);

%% Longitudinal laminate stiffness - used for panel calculation 
% see note in theory in .xlsx file
muxy=-(A(1,2)/A(2,2));
muyx=-(A(1,2)/A(1,1));

Ex=round((A(1,1)/t_tot)*(1-muxy*muyx),0); % Longitudinal laminate stiffness [MPa]
fprintf('Longitudinal laminate stiffness: %.0f MPa \n',Ex);

delete(wb);