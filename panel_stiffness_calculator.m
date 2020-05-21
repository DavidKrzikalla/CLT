%% Sandwich panel bending stiffness calculator
% Author: David Krzikalla

% Calculation of panel flexural rigidity (EI) based on FSAE and FSG rules
% Calculation of panel weights

% Imported data are taken from laminate_calc_theory_material_data.xlsx
% Before calculation get familiar with calc procedure aspects in the excel
% See note about laminate stiffness in the excel file, theory tab

clc
%% Material import
panel_mat=xlsread('laminate_calc_theory_material_data.xlsx','Stacking_sequence','D25:D31');

baseline_tub=xlsread('laminate_calc_theory_material_data.xlsx','Stacking_sequence','D36:D38');

%% Input data

f1=1; % Upper face thickness [mm]
Ef1=36384; % Upper Face Young modulus [MPa]
mf1=3612/2; % Upper face plane weight [g/m2]

f2=1; % Lower face thickness [mm]
Ef2=36384; % Lower Face Young modulus [MPa]
mf2=3612/2; % Lower face plane weight [g/m2]

bf=400; % actual estimated vehicle panel width [mm]
af=500; % actual estimated vehicle panel length [mm]

RC= 3932; % Rig compliance [N/mm], get from SES based on steel tubes testing

% %% Ec/Gc recalculation for isotropic core
% % In case of isotropic core can be used:
% muc= % Poisson ratio of core [-]
% 
% % Known Ec [MPa]
% Gc=Ec/(2*(1+muc)); 
% 
% % Known Gc [MPa]
% Ec=Gc*(2*(1+muc)); 
%% Calculation
c=panel_mat(1,1); % Core thickness [mm]
Ec=panel_mat(2,1); % Core Young modulus [MPa]
Gc=panel_mat(3,1); % Core Shear modulus [MPa]
L=400; % Minimal supports span [mm]
b=275; % Width of testing panel [mm]
h=c/2; % core half-thickness [mm]
D=Ef1*(((b*f1^3)/12)+(b*f1*(h+(f1/2))^2))+Ef2*(((b*f2^3)/12)+(b*f2*(h+(f2/2))^2))+Ec*((b*h^3)/12); % panel bending stiffness [N*mm2]
d=c+f1/2+f2/2; % effective panel height [mm]
Grad=1/((L^3/(48*D))+(L/(4*Gc*b*d))); % Force gradient [N/mm]
Dpanel=(Grad*L^3)/48; % Bending stiffness of the panel including shear stiffness [N*mm2]
Epanel=Dpanel/((b*((c+f1+f2)^3-c^3))/12); % Panel Young's modulus [MPa]

% Correction of values by Rig compliance
GradRC=1/((1/Grad)-(1/RC)); % Corrected gradient [N/mm]
DpanelRC=(GradRC*L^3)/48; % Bending stiffness of the panel including shear stiffness corrected by RC [N*mm2], this is compared to EI of tubes
EpanelRC=DpanelRC/((b*((c+f1+f2)^3-c^3))/12); % Panel Young's modulus corrected by RC [MPa]

% Bending stiffness of actual panel
Dpanelf=(EpanelRC*((bf*((c+f1+f2)^3-c^3))/12))/1000000; % [N*m2] 
%% Baseline steel tubing bending stiffness
% Calculation
n=baseline_tub(1,1); % no. of tubes required 
DO=baseline_tub(2,1); % Tube outer diameter [mm]
wt=baseline_tub(3,1); % wall thickness [mm]
Esteel=2e5; %YM of steel [MPa]
DI=DO-(2*wt); % Inner diameter [mm] 
I=(pi/64)*(DO^4-DI^4); % Second moment of inertia [mm^4]
EItube=(Esteel*I*n)/1000000; % bending stiffness baseline tubes [N*m2]

%% Comparison 
fprintf('Total panel thickness %.2f mm \n',c+f1+f2);

if Dpanelf>=EItube
    fprintf('Panel EI %.0f Nm^2, baseline tubes EI %.0f Nm^2 --> OK, %.0f %% \n',Dpanelf, EItube,Dpanelf/(EItube/100));
else
    fprintf('Panel %.0f Nm^2, baseline tubes %.0f Nm^2 --> NOT ok, %.0f %% \n',Dpanelf, EItube,Dpanelf/(EItube/100));
end

%% Panel mass estimation
mfaces=mf1+mf2; % faces plane weight[g/m2]

% Panel plain weight - mass of 1x1m panel 
M_plane=round(mfaces+panel_mat(7,1)*c,0); %  panel plane mass [g]
fprintf('Panel plane mass %.0f g/m^2 \n',M_plane);

% Specimen mass (thickness x 275 x 500 mm)
M_spec=round(M_plane*(0.275*0.5),0); % specimen panel mass [g]
fprintf('Specimen mass %.0f g \n',M_spec);

% Vehicle panel estimated weight
M_veh=round(M_plane*((bf/1000)*(af/1000)),0); % specimen panel mass [g]
fprintf('Estimated vehicle panel mass %.0f g \n',M_veh);