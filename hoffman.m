%% This function applies Hoffman criterion and returns Reserve Factor for each ply
% Author: David Krzikalla

% - Stress values from Sig_12 are used to calculate FI according to Hoffman criterion
% - Minimal Reserve Factor RF is calculated for each ply
% - RF should be higher than 1

 function RF_hoffman=hoffman(Sig_12,sig_tL,sig_tT,sig_cL,sig_cT,tau_TL)
 
AB=zeros(2,2,size(Sig_12,3));

i=1;
while i<=size(Sig_12,3) %plies 
    for k=1:2 % columns
        AB(1,k,i)=(Sig_12(1,k,i)^2/(sig_tL(1,i)*sig_cL(1,i)))+(Sig_12(2,k,i)^2/(sig_tT(1,i)*sig_cT(1,i)))+ ...
            (Sig_12(3,k,i)/tau_TL(1,i))^2-((Sig_12(1,k,i)*Sig_12(2,k,i))/(sig_tL(1,i)*sig_cL(1,i))); % coefficient A % row 1
        AB(2,k,i)=((1/sig_tL(1,i))-(1/sig_cL(1,i)))*Sig_12(1,k,i)+ ...
            ((1/sig_tT(1,i))-(1/sig_cT(1,i)))*Sig_12(2,k,i); % coefficient B % row 2
    end
i=i+1;
end

RF_temp=zeros(1,2,size(Sig_12,3));

for i=1:size(Sig_12,3)
    for k=1:2
        RF_temp(1,k,i)=(-AB(2,k,i)+sqrt(AB(2,k,i)^2+4*AB(1,k,i)))/(2*AB(1,k,i));
    end
end
    
RF_hoffman=zeros(size(Sig_12,3),1);
for i=size(Sig_12,3):-1:1
    RF_hoffman(i,1)=min(RF_temp(1,:,i));
end

RF_hoffman=round(RF_hoffman,3);
end