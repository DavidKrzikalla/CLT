%% This function applies maximal stress criterion and returns Reserve Factor for each ply
% Author: David Krzikalla

% Stress values from Sig_12 are compared to respective UTS
% Minimal Reserve Factor RF is calculated for each ply
% RF should be higher than 1

function RF_max_stress=max_stress_criterion(Sig_12,sig_tL,sig_cL,sig_tT,sig_cT,tau_TL)

FI=zeros(3,2,size(Sig_12,3));

i=1;
while i<=size(Sig_12,3) %plies 
    for k=1:2 % columns
        if Sig_12(1,k,i)>=0 %sigma 1 check
            FI(1,k,i)= sig_tL(1,i)/Sig_12(1,k,i);
        else
            FI(1,k,i)=abs(sig_cL(1,i)/Sig_12(1,k,i));
        end
        
        if Sig_12(2,k,i)>=0 %sigma 2 check
            FI(2,k,i)= sig_tT(1,i)/Sig_12(2,k,i);
        else
            FI(2,k,i)=abs(sig_cT(1,i)/Sig_12(2,k,i));
        end
        FI(3,k,i)=abs(tau_TL(1,i)/Sig_12(3,k,i)); %tau 12 check
    end
i=i+1;
end

RF_max_stress=zeros(size(Sig_12,3),1);
for i=size(FI,3):-1:1
    RF_max_stress(i,1)=min(min(FI(:,:,i)));
end

RF_max_stress=round(RF_max_stress,3);

end