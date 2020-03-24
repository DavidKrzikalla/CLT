%% This function applies Tsai-Hill criterion and returns Reserve Factor for each ply
% Author: David Krzikalla

% - Stress values from Sig_12 are used to calculate FI according to Tsai-Hill
% criterion
% - !!! The Tsai-Hill assume that UTS is tension and compression is the same !!!
% - Minimal Reserve Factor RF is calculated for each ply
% - RF should be higher than 1

function RF_tsai_hill=tsai_hill(Sig_12,sig_tL,sig_tT,tau_TL)

 FI=zeros(1,2,size(Sig_12,3));

i=1;
while i<=size(Sig_12,3) %plies 
    for k=1:2 % columns
        FI(1,k,i)=(Sig_12(1,k,i)/sig_tL(1,i))^2+(Sig_12(2,k,i)/sig_tT(1,i))^2 ...
            +(Sig_12(3,k,i)/tau_TL(1,i))^2-(Sig_12(1,k,i)*Sig_12(2,k,i)/sig_tL(1,i)^2);
    end
i=i+1;
end

RF_tsai_hill=zeros(size(Sig_12,3),1);
for i=size(FI,3):-1:1
    RF_tsai_hill(i,1)=1/sqrt(max(FI(:,:,i)));
end
end