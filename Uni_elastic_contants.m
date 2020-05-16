%% Analytical calculation of material constants of a UNIDIRECTIONAL composite

% These formulas apply only to unidirectional composites (unidirectional ply)
% To get elastic constants for stacked plies use CLT (see laminate_calculator.m)
% These formulas apply only to LONG FIBRE COMPOSITES
% Note restrictions for some of the formulas

clc
%% Given values 

Ef=75000; % Fibre Young's Modulus [MPa]
Em=5500; % Matrix Young's Modulus [MPa]
vf=0.6; % Fibre volumetric ratio [-]
muf=0.3; % Poisson ratio of fibre [-]
mum=0.32; % Poisson ratio of matrix [-]

%% Calculation

vm=1-vf; % Matrix volumetric ratio [-]
Kf=Ef/(3*(1-2*muf)); % bulk modulus of fiber [MPa]
Km=Em/(3*(1-2*mum)); % bulk modulus of matrix [MPa]

Gf=Ef/(2*(1+muf)); % shear modulus of fiber [MPa]
Gm=Em/(2*(1+mum)); % shear modulus of matrix [MPa]

EL=round(vf*Ef+vm*Em,0) % Longitudinal Young's Modulus, mixture rule (accurate) [MPa]

muLT=round(vf*muf+vm*mum,2) % Poisson ratio LT, mixture rule (accurate) [-]

% Transversal Young's Modulus - Halpin-Tsai model, inaccuracy in tenths of percent generaly
ksi=1; % fitting constant, use 1 for estimation, more accurate only based on experimental data
eta=((Ef/Em)-1)/((Ef/Em)+ksi); % for carbon fibres (anisotropic) use for Ef carbon fibre longitudinal YM
ET_HT=round(Em*((1+eta*ksi*vf)/(1-eta*vf)),0) % [MPa]

% Poisson ratio TT' - Clyne model
% Values are possible to be more than 0.5, physical reasons behind
K=((vf/Kf)+(vm/Km))^(-1);
muTL=(ET_HT/EL)*muLT;
mutt=round(1-muTL-(ET_HT/(3*K)),2)

% Shear modulus GLT 
% Mixture rule, the lowest boundary of GLT
GLT_mix=round((vf/Gf+vm/Gm)^(-1),0) % [MPa]

% Halpin-Tsai model - use when ksi is detemined from experiemnt or known
ksi_glt=1; % fitting constant, use 1 for estimation, more accurate only based on experimental data
eta_glt=((Gf/Gm)-1)/((Gf/Gm)+ksi_glt);
GLT_HT=round(Gm*((1+eta_glt*ksi_glt*vf)/(1-eta_glt*vf)),0) % [MPa]

% Shear modulus GTT
Gtt=round(ET_HT/(2*(1+mutt)),0)  % [MPa]

