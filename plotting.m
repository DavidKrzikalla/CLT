%% This function serves to plot stress and strain fields over laminate thickness
% Author: David Krzikalla

function plotting(Eps_res,Sig_res, Z_coor,h)

%% Strain plotting
% In general coordiantes

figure % strain plot, general coordinate 
subplot(3,1,1);
for i=1:length(h)
    plot([min(min(Eps_res(:,3:5)))-0.0003,max(max(abs(Eps_res(:,3:5))))+0.0003],[h(1,i) h(1,i)],':k','LineWidth',0.8); hold on % vertical ply line
end
plot([min(min(Eps_res(:,3:5)))-0.0004,max(max(abs(Eps_res(:,3:5))))+0.0004],[0 0],'-.r'); hold on % horizontal zero line, middle plane line
plot([min(min(Eps_res(:,3:5)))-0.0003,max(max(abs(Eps_res(:,3:5))))+0.0003],[h(1,end) h(1,end)],'k','LineWidth',1.5); % horizontal laminate top line
plot([min(min(Eps_res(:,3:5)))-0.0003,max(max(abs(Eps_res(:,3:5))))+0.0003],[h(1,1) h(1,1)],'k','LineWidth',1.5); % horizontal laminate bottom line
plot([0,0],[Z_coor(end,2)-0.0015,Z_coor(1,2)+0.0015],'--r'); % vertical zero line
plot([min(min(Eps_res(:,3:5)))-0.0003 ,min(min(Eps_res(:,3:5)))-0.0003],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical left edge line
plot([max(max(abs(Eps_res(:,3:5))))+0.0003,max(max(abs(Eps_res(:,3:5))))+0.0003],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical right edge line

plot(Eps_res(:,3),Z_coor(:,2),'-b*','LineWidth',1) % calculated value plot
%ylim([h(1,1)-0.1 h(1,end)+0.1]) 
%xlim([Eps_res(end,3)-0.001 Eps_res(1,3)+0.001])
xlabel('Strain, $\epsilon_x$ [-]','Interpreter','latex')
ylabel('Position [mm]','Interpreter','latex')
title('Strain in General Coordinate System')


subplot(3,1,2);
for i=1:length(h)
    plot([min(min(Eps_res(:,3:5)))-0.0003,max(max(abs(Eps_res(:,3:5))))+0.0003],[h(1,i) h(1,i)],':k','LineWidth',0.8); hold on % vertical ply line
end
plot([min(min(Eps_res(:,3:5)))-0.0004,max(max(abs(Eps_res(:,3:5))))+0.0004],[0 0],'-.r'); hold on % horizontal zero line, middle plane line
plot([min(min(Eps_res(:,3:5)))-0.0003,max(max(abs(Eps_res(:,3:5))))+0.0003],[h(1,end) h(1,end)],'k','LineWidth',1.5); % horizontal laminate top line
plot([min(min(Eps_res(:,3:5)))-0.0003,max(max(abs(Eps_res(:,3:5))))+0.0003],[h(1,1) h(1,1)],'k','LineWidth',1.5); % horizontal laminate bottom line
plot([0,0],[Z_coor(end,2)-0.0015,Z_coor(1,2)+0.0015],'--r'); % vertical zero line
plot([min(min(Eps_res(:,3:5)))-0.0003 ,min(min(Eps_res(:,3:5)))-0.0003],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical left edge line
plot([max(max(abs(Eps_res(:,3:5))))+0.0003,max(max(abs(Eps_res(:,3:5))))+0.0003],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical right edge line

plot(Eps_res(:,4),Z_coor(:,2),'-bs','LineWidth',1) % calculated value plot
%ylim([h(1,1)-0.005 h(1,end)+0.1]) 
%xlim([Eps_res(end,3)-0.001 Eps_res(1,3)+0.001])
xlabel('Strain, $\epsilon_y$ [-]','Interpreter','latex')
ylabel('Position [mm]','Interpreter','latex')



subplot(3,1,3);
for i=1:length(h)
    plot([min(min(Eps_res(:,3:5)))-0.0003,Eps_res(1,3)+0.0003],[h(1,i) h(1,i)],':k','LineWidth',0.8); hold on % vertical ply line
end
plot([min(min(Eps_res(:,3:5)))-0.0004,max(max(abs(Eps_res(:,3:5))))+0.0004],[0 0],'-.r'); hold on % horizontal zero line, middle plane line
plot([min(min(Eps_res(:,3:5)))-0.0003,max(max(abs(Eps_res(:,3:5))))+0.0003],[h(1,end) h(1,end)],'k','LineWidth',1.5); % horizontal laminate top line
plot([min(min(Eps_res(:,3:5)))-0.0003,max(max(abs(Eps_res(:,3:5))))+0.0003],[h(1,1) h(1,1)],'k','LineWidth',1.5); % horizontal laminate bottom line
plot([0,0],[Z_coor(end,2)-0.0015,Z_coor(1,2)+0.0015],'--r'); % vertical zero line
plot([min(min(Eps_res(:,3:5)))-0.0003 ,min(min(Eps_res(:,3:5)))-0.0003],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical left edge line
plot([max(max(abs(Eps_res(:,3:5))))+0.0003,max(max(abs(Eps_res(:,3:5))))+0.0003],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical right edge line

plot(Eps_res(:,5),Z_coor(:,2),'-b^','LineWidth',1) % calculated value plot
%ylim([h(1,1)-0.005 h(1,end)+0.005]) 
%xlim([Eps_res(end,3)-0.001 Eps_res(1,3)+0.001])
xlabel('Strain, $\gamma_{xy}$ [-]','Interpreter','latex')
ylabel('Position [mm]','Interpreter','latex')

%% Strain plotting
% In material coordiantes

figure % strain plot, material coordinate 
subplot(3,1,1);
for i=1:length(h)
    plot([min(min(Eps_res(:,3+3:5+3)))-0.0003,max(max(abs(Eps_res(:,3+3:5+3))))+0.0003],[h(1,i) h(1,i)],':k','LineWidth',0.8); hold on % vertical ply line
end
plot([min(min(Eps_res(:,3+3:5+3)))-0.0004,max(max(abs(Eps_res(:,3+3:5+3))))+0.0004],[0 0],'-.r'); hold on % horizontal zero line, middle plane line
plot([min(min(Eps_res(:,3+3:5+3)))-0.0003,max(max(abs(Eps_res(:,3+3:5+3))))+0.0003],[h(1,end) h(1,end)],'k','LineWidth',1.5); % horizontal laminate top line
plot([min(min(Eps_res(:,3+3:5+3)))-0.0003,max(max(abs(Eps_res(:,3+3:5+3))))+0.0003],[h(1,1) h(1,1)],'k','LineWidth',1.5); % horizontal laminate bottom line
plot([0,0],[Z_coor(end,2)-0.0015,Z_coor(1,2)+0.0015],'--r'); % vertical zero line
plot([min(min(Eps_res(:,3+3:5+3)))-0.0003 ,min(min(Eps_res(:,3+3:5+3)))-0.0003],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical left edge line
plot([max(max(abs(Eps_res(:,3+3:5+3))))+0.0003,max(max(abs(Eps_res(:,3+3:5+3))))+0.0003],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical right edge line

plot(Eps_res(:,3+3),Z_coor(:,2),'-k*','LineWidth',1) % calculated value plot
%ylim([h(1,1)-0.005 h(1,end)+0.005]) 
%xlim([Eps_res(end,3)-0.001 Eps_res(1,3)+0.001])
xlabel('Strain, $\epsilon_1$ [-]','Interpreter','latex')
ylabel('Position [mm]','Interpreter','latex')
title('Strain in Material Coordinate System')


subplot(3,1,2);
for i=1:length(h)
    plot([min(min(Eps_res(:,3+3:5+3)))-0.0003,max(max(abs(Eps_res(:,3+3:5+3))))+0.0003],[h(1,i) h(1,i)],':k','LineWidth',0.8); hold on % vertical ply line
end
plot([min(min(Eps_res(:,3+3:5+3)))-0.0004,max(max(abs(Eps_res(:,3+3:5+3))))+0.0004],[0 0],'-.r'); hold on % horizontal zero line, middle plane line
plot([min(min(Eps_res(:,3+3:5+3)))-0.0003,max(max(abs(Eps_res(:,3+3:5+3))))+0.0003],[h(1,end) h(1,end)],'k','LineWidth',1.5); % horizontal laminate top line
plot([min(min(Eps_res(:,3+3:5+3)))-0.0003,max(max(abs(Eps_res(:,3+3:5+3))))+0.0003],[h(1,1) h(1,1)],'k','LineWidth',1.5); % horizontal laminate bottom line
plot([0,0],[Z_coor(end,2)-0.0015,Z_coor(1,2)+0.0015],'--r'); % vertical zero line
plot([min(min(Eps_res(:,3+3:5+3)))-0.0003 ,min(min(Eps_res(:,3+3:5+3)))-0.0003],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical left edge line
plot([max(max(abs(Eps_res(:,3+3:5+3))))+0.0003,max(max(abs(Eps_res(:,3+3:5+3))))+0.0003],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical right edge line

plot(Eps_res(:,4+3),Z_coor(:,2),'-ks','LineWidth',1) % calculated value plot
%ylim([h(1,1)-0.005 h(1,end)+0.005]) 
%xlim([Eps_res(end,3)-0.001 Eps_res(1,3)+0.001])
xlabel('Strain, $\epsilon_2$ [-]','Interpreter','latex')
ylabel('Position [mm]','Interpreter','latex')



subplot(3,1,3);
for i=1:length(h)
    plot([min(min(Eps_res(:,3+3:5+3)))-0.0003,max(max(abs(Eps_res(:,3+3:5+3))))+0.0003],[h(1,i) h(1,i)],':k','LineWidth',0.8); hold on % vertical ply line
end
plot([min(min(Eps_res(:,3+3:5+3)))-0.0004,max(max(abs(Eps_res(:,3+3:5+3))))+0.0004],[0 0],'-.r'); hold on % horizontal zero line, middle plane line
plot([min(min(Eps_res(:,3+3:5+3)))-0.0003,max(max(abs(Eps_res(:,3+3:5+3))))+0.0003],[h(1,end) h(1,end)],'k','LineWidth',1.5); % horizontal laminate top line
plot([min(min(Eps_res(:,3+3:5+3)))-0.0003,max(max(abs(Eps_res(:,3+3:5+3))))+0.0003],[h(1,1) h(1,1)],'k','LineWidth',1.5); % horizontal laminate bottom line
plot([0,0],[Z_coor(end,2)-0.0015,Z_coor(1,2)+0.0015],'--r'); % vertical zero line
plot([min(min(Eps_res(:,3+3:5+3)))-0.0003 ,min(min(Eps_res(:,3+3:5+3)))-0.0003],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical left edge line
plot([max(max(abs(Eps_res(:,3+3:5+3))))+0.0003,max(max(abs(Eps_res(:,3+3:5+3))))+0.0003],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical right edge line

plot(Eps_res(:,5+3),Z_coor(:,2),'-k^','LineWidth',1) % calculated value plot
%ylim([h(1,1)-0.005 h(1,end)+0.005]) 
%xlim([Eps_res(end,3)-0.001 Eps_res(1,3)+0.001])
xlabel('Strain, $\gamma_{12}$ [-]','Interpreter','latex')
ylabel('Position [mm]','Interpreter','latex')

%% Stress plotting
% In general coordiantes

figure % stress plot, general coordinate 
subplot(3,1,1);
for i=1:length(h)
    plot([min(min(Sig_res(:,3:5)))-10,max(max(abs(Sig_res(:,3:5))))+10],[h(1,i) h(1,i)],':k','LineWidth',0.8); hold on % vertical ply line
end
plot([min(min(Sig_res(:,3:5)))-15,max(max(abs(Sig_res(:,3:5))))+15],[0 0],'-.r'); hold on % horizontal zero line, middle plane line
plot([min(min(Sig_res(:,3:5)))-10,max(max(abs(Sig_res(:,3:5))))+10],[h(1,end) h(1,end)],'k','LineWidth',1.5); % horizontal laminate top line
plot([min(min(Sig_res(:,3:5)))-10,max(max(abs(Sig_res(:,3:5))))+10],[h(1,1) h(1,1)],'k','LineWidth',1.5); % horizontal laminate bottom line
plot([0,0],[Z_coor(end,2)-0.0015,Z_coor(1,2)+0.0015],'--r'); % vertical zero line
plot([min(min(Sig_res(:,3:5)))-10 ,min(min(Sig_res(:,3:5)))-10],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical left edge line
plot([max(max(abs(Sig_res(:,3:5))))+10,max(max(abs(Sig_res(:,3:5))))+10],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical right edge line

plot(Sig_res(:,3),Z_coor(:,2),'-b*','LineWidth',1) % calculated value plot
%ylim([h(1,1)-0.005 h(1,end)+0.005]) 
%xlim([Eps_res(end,3)-0.001 Eps_res(1,3)+0.001])
xlabel('Stress, $\sigma_x$ [MPa]','Interpreter','latex')
ylabel('Position [mm]','Interpreter','latex')
title('Stress in General Coordinate System')


subplot(3,1,2);
for i=1:length(h)
    plot([Sig_res(end,3)-10,max(max(abs(Sig_res(:,3:5))))+10],[h(1,i) h(1,i)],':k','LineWidth',0.8); hold on % vertical ply line
end
plot([min(min(Sig_res(:,3:5)))-15,max(max(abs(Sig_res(:,3:5))))+15],[0 0],'-.r'); hold on % horizontal zero line, middle plane line
plot([min(min(Sig_res(:,3:5)))-10,max(max(abs(Sig_res(:,3:5))))+10],[h(1,end) h(1,end)],'k','LineWidth',1.5); % horizontal laminate top line
plot([min(min(Sig_res(:,3:5)))-10,max(max(abs(Sig_res(:,3:5))))+10],[h(1,1) h(1,1)],'k','LineWidth',1.5); % horizontal laminate bottom line
plot([0,0],[Z_coor(end,2)-0.0015,Z_coor(1,2)+0.0015],'--r'); % vertical zero line
plot([min(min(Sig_res(:,3:5)))-10 ,min(min(Sig_res(:,3:5)))-10],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical left edge line
plot([max(max(abs(Sig_res(:,3:5))))+10,max(max(abs(Sig_res(:,3:5))))+10],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical right edge line

plot(Sig_res(:,4),Z_coor(:,2),'-bs','LineWidth',1) % calculated value plot
%ylim([h(1,1)-0.005 h(1,end)+0.005]) 
%xlim([Eps_res(end,3)-0.001 Eps_res(1,3)+0.001])
xlabel('Stress, $\sigma_y$ [MPa]','Interpreter','latex')
ylabel('Position [mm]','Interpreter','latex')



subplot(3,1,3);
for i=1:length(h)
    plot([min(min(Sig_res(:,3:5)))-10,max(max(abs(Sig_res(:,3:5))))+10],[h(1,i) h(1,i)],':k','LineWidth',0.8); hold on % vertical ply line
end
plot([min(min(Sig_res(:,3:5)))-15,max(max(abs(Sig_res(:,3:5))))+15],[0 0],'-.r'); hold on % horizontal zero line, middle plane line
plot([min(min(Sig_res(:,3:5)))-10,max(max(abs(Sig_res(:,3:5))))+10],[h(1,end) h(1,end)],'k','LineWidth',1.5); % horizontal laminate top line
plot([min(min(Sig_res(:,3:5)))-10,max(max(abs(Sig_res(:,3:5))))+10],[h(1,1) h(1,1)],'k','LineWidth',1.5); % horizontal laminate bottom line
plot([0,0],[Z_coor(end,2)-0.0015,Z_coor(1,2)+0.0015],'--r'); % vertical zero line
plot([min(min(Sig_res(:,3:5)))-10 ,min(min(Sig_res(:,3:5)))-10],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical left edge line
plot([max(max(abs(Sig_res(:,3:5))))+10,max(max(abs(Sig_res(:,3:5))))+10],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical right edge line

plot(Sig_res(:,5),Z_coor(:,2),'-b^','LineWidth',1) % calculated value plot
%ylim([h(1,1)-0.005 h(1,end)+0.005]) 
%xlim([Eps_res(end,3)-0.001 Eps_res(1,3)+0.001])
xlabel('Stress, $\tau_{xy}$ [MPa]','Interpreter','latex')
ylabel('Position [mm]','Interpreter','latex')

%% Stress plotting
% In material coordiantes

figure % stress plot, material coordinate 
subplot(3,1,1);
for i=1:length(h)
    plot([min(min(Sig_res(:,3+3:5+3)))-10,max(max(abs(Sig_res(:,3+3:5+3))))+10],[h(1,i) h(1,i)],':k','LineWidth',0.8); hold on % vertical ply line
end
plot([min(min(Sig_res(:,3+3:5+3)))-15,max(max(abs(Sig_res(:,3+3:5+3))))+15],[0 0],'-.r'); hold on % horizontal zero line, middle plane line
plot([min(min(Sig_res(:,3+3:5+3)))-10,max(max(abs(Sig_res(:,3+3:5+3))))+10],[h(1,end) h(1,end)],'k','LineWidth',1.5); % horizontal laminate top line
plot([min(min(Sig_res(:,3+3:5+3)))-10,max(max(abs(Sig_res(:,3+3:5+3))))+10],[h(1,1) h(1,1)],'k','LineWidth',1.5); % horizontal laminate bottom line
plot([0,0],[Z_coor(end,2)-0.0015,Z_coor(1,2)+0.0015],'--r'); % vertical zero line
plot([min(min(Sig_res(:,3+3:5+3)))-10 ,min(min(Sig_res(:,3+3:5+3)))-10],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical left edge line
plot([max(max(abs(Sig_res(:,3+3:5+3))))+10,max(max(abs(Sig_res(:,3+3:5+3))))+10],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical right edge line

plot(Sig_res(:,3+3),Z_coor(:,2),'-k*','LineWidth',1) % calculated value plot
%ylim([h(1,1)-0.005 h(1,end)+0.005]) 
%xlim([Eps_res(end,3)-0.001 Eps_res(1,3)+0.001])
xlabel('Stress, $\sigma_1$ [-]','Interpreter','latex')
ylabel('Position [mm]','Interpreter','latex')
title('Stress in Material Coordinate System')


subplot(3,1,2);
for i=1:length(h)
    plot([min(min(Sig_res(:,3+3:5+3)))-10,max(max(abs(Sig_res(:,3+3:5+3))))+10],[h(1,i) h(1,i)],':k','LineWidth',0.8); hold on % vertical ply line
end
plot([min(min(Sig_res(:,3+3:5+3)))-15,max(max(abs(Sig_res(:,3+3:5+3))))+15],[0 0],'-.r'); hold on % horizontal zero line, middle plane line
plot([min(min(Sig_res(:,3+3:5+3)))-10,max(max(abs(Sig_res(:,3+3:5+3))))+10],[h(1,end) h(1,end)],'k','LineWidth',1.5); % horizontal laminate top line
plot([min(min(Sig_res(:,3+3:5+3)))-10,max(max(abs(Sig_res(:,3+3:5+3))))+10],[h(1,1) h(1,1)],'k','LineWidth',1.5); % horizontal laminate bottom line
plot([0,0],[Z_coor(end,2)-0.0015,Z_coor(1,2)+0.0015],'--r'); % vertical zero line
plot([min(min(Sig_res(:,3+3:5+3)))-10 ,min(min(Sig_res(:,3+3:5+3)))-10],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical left edge line
plot([max(max(abs(Sig_res(:,3+3:5+3))))+10,max(max(abs(Sig_res(:,3+3:5+3))))+10],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical right edge line

plot(Sig_res(:,4+3),Z_coor(:,2),'-ks','LineWidth',1) % calculated value plot
%ylim([h(1,1)-0.005 h(1,end)+0.005]) 
%xlim([Eps_res(end,3)-0.001 Eps_res(1,3)+0.001])
xlabel('Stress, $\sigma_2$ [-]','Interpreter','latex')
ylabel('Position [mm]','Interpreter','latex')



subplot(3,1,3);
for i=1:length(h)
    plot([min(min(Sig_res(:,3+3:5+3)))-10,max(max(abs(Sig_res(:,3+3:5+3))))+10],[h(1,i) h(1,i)],':k','LineWidth',0.8); hold on % vertical ply line
end
plot([min(min(Sig_res(:,3+3:5+3)))-15,max(max(abs(Sig_res(:,3+3:5+3))))+15],[0 0],'-.r'); hold on % horizontal zero line, middle plane line
plot([min(min(Sig_res(:,3+3:5+3)))-10,max(max(abs(Sig_res(:,3+3:5+3))))+10],[h(1,end) h(1,end)],'k','LineWidth',1.5); % horizontal laminate top line
plot([min(min(Sig_res(:,3+3:5+3)))-10,max(max(abs(Sig_res(:,3+3:5+3))))+10],[h(1,1) h(1,1)],'k','LineWidth',1.5); % horizontal laminate bottom line
plot([0,0],[Z_coor(end,2)-0.0015,Z_coor(1,2)+0.0015],'--r'); % vertical zero line
plot([min(min(Sig_res(:,3+3:5+3)))-10 ,min(min(Sig_res(:,3+3:5+3)))-10],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical left edge line
plot([max(max(abs(Sig_res(:,3+3:5+3))))+10,max(max(abs(Sig_res(:,3+3:5+3))))+10],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5); % vertical right edge line

plot(Sig_res(:,5+3),Z_coor(:,2),'-k^','LineWidth',1) % calculated value plot
%ylim([h(1,1)-0.005 h(1,end)+0.005]) 
%xlim([Eps_res(end,3)-0.001 Eps_res(1,3)+0.001])
xlabel('Stress, $\tau_{12}$ [-]','Interpreter','latex')
ylabel('Position [mm]','Interpreter','latex')

end