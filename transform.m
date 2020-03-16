%% This function transforms values using T matrix

function T=transform(angle)

phi=deg2rad(angle);

T=[cos(phi)^2 sin(phi)^2 2*sin(phi)*cos(phi);
    sin(phi)^2 cos(phi)^2 -2*sin(phi)*cos(phi);
    -sin(phi)*cos(phi) sin(phi)*cos(phi) cos(phi)^2-sin(phi)^2];
end