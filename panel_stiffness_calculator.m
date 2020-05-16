%% Sandwich panel bending stiffness calculator
clc
%% Input data

L=400; % Supports span [mm]
b=275; % Width [mm]

h=15; % Core half-thickness [mm]
f1=0.5; % Upper face thickness [mm]
f2=0.5; % Lower face thickness [mm]

Ef1=40000; % Upper Face Young modulus [MPa]
Ef2=42000; % Lower Face Young modulus [MPa]
Ec=212; % Core Young modulus [MPa]
Gc=100; % Core Shear modulus [MPa]

RC= 2000; % Rig compliance [N], get from SES based on steel tubes testing

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

D=Ef1*(((b*f1^3)/12)+(b*f1*(h+(f1/2))^2))+Ef2*(((b*f2^3)/12)+(b*f2*(h+(f2/2))^2))+Ec*((b*h^3)/12); % panel bending stiffness [N*mm2]
d=2*h+f1/2+f2/2; % effective panel height [mm]
Grad=1/((L^3/(48*D))+(L/(4*Gc*b*d))); % Force gradient [N/mm]
Dpanel=(Grad*L^3)/48; % Bending stiffness of the panel including shear stiffness [N*mm2]
Epanel=Dpanel/((b*(h^3-(2*h)^3))/12); % Panel Young's modulus [MPa]

% Correction of values by Rig compliance
GradRC=1/((1/Grad)-(1/RC)); % Corrected gradient [N/mm
DpanelRC=(GradRC*L^3)/48 % Bending stiffness of the panel including shear stiffness corrected by RC [N*mm2], this is compared to EI of tubes
EpanelRC=DpanelRC/((b*((2*h+f1+f2)^3-(2*h)^3))/12); % Panel Young's modulus corrected by RC [MPa]

% zkontrolovat vzorce
% doprogramovat porovnani s EI trubek
