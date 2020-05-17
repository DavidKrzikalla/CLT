%% Sandwich panel bending stiffness calculator
clc
%% Input data

c=25; % Core thickness [mm]
f1=0.66; % Upper face thickness [mm]
f2=0.64; % Lower face thickness [mm]
bf=200; % actual vehicle panel width [mm]

Ef1=46936; % Upper Face Young modulus [MPa]
Ef2=40698; % Lower Face Young modulus [MPa]
Ec=138; % Core Young modulus [MPa]
Gc=48; % Core Shear modulus [MPa]

RC= 3932; % Rig compliance [N/mm], get from SES based on steel tubes testing

% Input requied baseline tubes for equivalence
n=1; % no. of tubes required 
DO=25.4; % Tube outer diameter [mm]
wt=1.6; % wall thickness [mm]

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
Esteel=2e5; %YM of steel [MPa]
DI=DO-(2*wt); % Inner diameter [mm] 
I=(pi/64)*(DO^4-DI^4); % Second moment of inertia [mm^4]
EItube=(Esteel*I*n)/1000000; % bending stiffness baseline tubes [N*m2]

%% Comparison 
fprintf('Total panel thickness %.2f mm \n',c+f1+f2);
fprintf('Panel %.0f Nm^2, baseline tubes %.0f Nm^2 \n',Dpanelf, EItube);

if Dpanelf>=EItube
    fprintf('OK, %.0f %% \n',Dpanelf/(EItube/100));
else
    fprintf('NOT ok, %.0f %% \n',Dpanelf/(EItube/100));
end
    