%% This function creates results tables for stress and strain 
% Author: David Krzikalla

% Stress and strain tables are created for general and material coordinate
%system
% Finaly, those tables are combined with Z_coordinate of particular ply
%edge together with corresponding ply No.

function [Eps_res, Sig_res,Z_coor]=results_table(Eps_xy,Eps_12,Sig_xy,Sig_12,z,angle)


Eps_xy=round(Eps_xy,5);
Sig_xy=round(Sig_xy,1);
Eps_12=round(Eps_12,5);
Sig_12=round(Sig_12,1);


Eps_res=zeros(length(angle)*2,6); %zero matrix (ply top, bottom vs ex,ey,gxy,e1,e2,g12)

j=1;
while j<=length(angle)*2-1
    for i=length(angle):-1:1
        for k=1:3
            Eps_res(j,k)=Eps_xy(k,2,i);
            Eps_res(j,k+3)=Eps_12(k,2,i);
            Eps_res(j+1,k)=Eps_xy(k,1,i);
            Eps_res(j+1,k+3)=Eps_12(k,1,i);
        end
    j=j+2;
    end
end

Sig_res=zeros(length(angle)*2,6); %zero matrix (ply top, bottom vs sx,sy,tauxy,s1,s2,tau12)

j=1;
while j<=length(angle)*2-1
    for i=length(angle):-1:1
        for k=1:3
            Sig_res(j,k)=Sig_xy(k,2,i);
            Sig_res(j,k+3)=Sig_12(k,2,i);
            Sig_res(j+1,k)=Sig_xy(k,1,i);
            Sig_res(j+1,k+3)=Sig_12(k,1,i);
        end
    j=j+2;
    end
end

Z_coor=zeros(length(angle)*2,2); %zero matrix for plies' Z_coordinate vector

j=1;
while j<=length(angle)*2-1
    for i=size(z,1):-1:1
        Z_coor(j,2)=z(i,2);
        Z_coor(j+1,2)=z(i,1);
        Z_coor(j,1)=i;
        Z_coor(j+1,1)=i;
    j=j+2;
    end
end
    
Z_coor=round(Z_coor,4);

Eps_res=[Z_coor Eps_res];
Sig_res=[Z_coor Sig_res];
end