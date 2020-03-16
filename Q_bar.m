%% This function calculates Q_bar matrix for given ply

function [Q_bar]=Q_bar(E1,E2,G12,v12,angle)

v21=E2/E1*v12;
phi=deg2rad(angle);

Q=[(E1/(1-v12*v21)) (v12*E2/(1-v12*v21)) 0;
    (v12*E2/(1-v12*v21)) (E2/(1-v12*v21)) 0;
    0 0 G12];

T=[cos(phi)^2 sin(phi)^2 2*sin(phi)*cos(phi);
    sin(phi)^2 cos(phi)^2 -2*sin(phi)*cos(phi);
    -sin(phi)*cos(phi) sin(phi)*cos(phi) cos(phi)^2-sin(phi)^2];

Q_bar=inv(T)*Q*inv(transpose(T));
end