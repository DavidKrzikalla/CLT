%% This function serves to plot stress and strain fields over laminate thickness
% Author: David Krzikalla

function plotting(Eps_res,Sig_res, Z_coor,h)

%% Strain plotting

% In general coordiantes
figure 
subplot(2,1,1);
for i=1:length(h)
    plot([min(min(Eps_res(:,3:5)))-0.0003,max(max(abs(Eps_res(:,3:5))))+0.0003],[h(1,i) h(1,i)],':k','LineWidth',0.8,'HandleVisibility','off'); hold on % vertical ply line
end
plot([min(min(Eps_res(:,3:5)))-0.0004,max(max(abs(Eps_res(:,3:5))))+0.0004],[0 0],'-.r','HandleVisibility','off'); % horizontal zero line, middle plane line
plot([min(min(Eps_res(:,3:5)))-0.0003,max(max(abs(Eps_res(:,3:5))))+0.0003],[h(1,end) h(1,end)],'k','LineWidth',1.5,'HandleVisibility','off'); % horizontal laminate top line
plot([min(min(Eps_res(:,3:5)))-0.0003,max(max(abs(Eps_res(:,3:5))))+0.0003],[h(1,1) h(1,1)],'k','LineWidth',1.5,'HandleVisibility','off'); % horizontal laminate bottom line
plot([0,0],[Z_coor(end,2)-0.0015,Z_coor(1,2)+0.0015],'--r','HandleVisibility','off'); % vertical zero line
plot([min(min(Eps_res(:,3:5)))-0.0003 ,min(min(Eps_res(:,3:5)))-0.0003],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5,'HandleVisibility','off'); % vertical left edge line
plot([max(max(abs(Eps_res(:,3:5))))+0.0003,max(max(abs(Eps_res(:,3:5))))+0.0003],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5,'HandleVisibility','off'); % vertical right edge line

plot(Eps_res(:,3),Z_coor(:,2),'-*','LineWidth',1) % epsilon_x
plot(Eps_res(:,4),Z_coor(:,2),'-s','LineWidth',1) % epsilon_y
plot(Eps_res(:,5),Z_coor(:,2),'-^','LineWidth',1) % gama_xy
%ylim([h(1,1)-0.1 h(1,end)+0.1]) 
%xlim([Eps_res(end,3)-0.001 Eps_res(1,3)+0.001])
xlabel('Strain [-]')
ylabel('Position [mm]')
tit1=title('Strain in General Coordinate System');
lgd1=legend('\epsilon_x','\epsilon_y','\gamma_{xy}');
lgd1.FontSize=12;
lgd1.FontWeight='bold';
tit1.FontSize=15;
tit1.FontWeight='bold';


% In material coordiantes
subplot(2,1,2);
for i=1:length(h)
    plot([min(min(Eps_res(:,3+3:5+3)))-0.0003,max(max(abs(Eps_res(:,3+3:5+3))))+0.0003],[h(1,i) h(1,i)],':k','LineWidth',0.8,'HandleVisibility','off'); hold on % vertical ply line
end
plot([min(min(Eps_res(:,3+3:5+3)))-0.0004,max(max(abs(Eps_res(:,3+3:5+3))))+0.0004],[0 0],'-.r','HandleVisibility','off'); % horizontal zero line, middle plane line
plot([min(min(Eps_res(:,3+3:5+3)))-0.0003,max(max(abs(Eps_res(:,3+3:5+3))))+0.0003],[h(1,end) h(1,end)],'k','LineWidth',1.5,'HandleVisibility','off'); % horizontal laminate top line
plot([min(min(Eps_res(:,3+3:5+3)))-0.0003,max(max(abs(Eps_res(:,3+3:5+3))))+0.0003],[h(1,1) h(1,1)],'k','LineWidth',1.5,'HandleVisibility','off'); % horizontal laminate bottom line
plot([0,0],[Z_coor(end,2)-0.0015,Z_coor(1,2)+0.0015],'--r','HandleVisibility','off'); % vertical zero line
plot([min(min(Eps_res(:,3+3:5+3)))-0.0003 ,min(min(Eps_res(:,3+3:5+3)))-0.0003],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5,'HandleVisibility','off'); % vertical left edge line
plot([max(max(abs(Eps_res(:,3+3:5+3))))+0.0003,max(max(abs(Eps_res(:,3+3:5+3))))+0.0003],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5,'HandleVisibility','off'); % vertical right edge line

plot(Eps_res(:,3+3),Z_coor(:,2),'-*','LineWidth',1) % epsilon 1
plot(Eps_res(:,4+3),Z_coor(:,2),'-s','LineWidth',1) % epsilon 2
plot(Eps_res(:,5+3),Z_coor(:,2),'-^','LineWidth',1) % gama 12
%ylim([h(1,1)-0.005 h(1,end)+0.005]) 
%xlim([Eps_res(end,3)-0.001 Eps_res(1,3)+0.001])
xlabel('Strain [-]')
ylabel('Position [mm]')
tit2=title('Strain in Material Coordinate System');
lgd2=legend('\epsilon_1','\epsilon_2','\gamma_{12}');
lgd2.FontSize=12;
lgd2.FontWeight='bold';
tit2.FontSize=15;
tit2.FontWeight='bold';

%% Stress plotting

% In general coordiantes
figure
subplot(2,1,1);
for i=1:length(h)
    plot([min(min(Sig_res(:,3:5)))-10,max(max(abs(Sig_res(:,3:5))))+10],[h(1,i) h(1,i)],':k','LineWidth',0.8,'HandleVisibility','off'); hold on % vertical ply line
end
plot([min(min(Sig_res(:,3:5)))-15,max(max(abs(Sig_res(:,3:5))))+15],[0 0],'-.r','HandleVisibility','off'); hold on % horizontal zero line, middle plane line
plot([min(min(Sig_res(:,3:5)))-10,max(max(abs(Sig_res(:,3:5))))+10],[h(1,end) h(1,end)],'k','LineWidth',1.5,'HandleVisibility','off'); % horizontal laminate top line
plot([min(min(Sig_res(:,3:5)))-10,max(max(abs(Sig_res(:,3:5))))+10],[h(1,1) h(1,1)],'k','LineWidth',1.5,'HandleVisibility','off'); % horizontal laminate bottom line
plot([0,0],[Z_coor(end,2)-0.0015,Z_coor(1,2)+0.0015],'--r','HandleVisibility','off'); % vertical zero line
plot([min(min(Sig_res(:,3:5)))-10 ,min(min(Sig_res(:,3:5)))-10],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5,'HandleVisibility','off'); % vertical left edge line
plot([max(max(abs(Sig_res(:,3:5))))+10,max(max(abs(Sig_res(:,3:5))))+10],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5,'HandleVisibility','off'); % vertical right edge line

plot(Sig_res(:,3),Z_coor(:,2),'-*','LineWidth',1) % sigma x
plot(Sig_res(:,4),Z_coor(:,2),'-s','LineWidth',1) % sigma y
plot(Sig_res(:,5),Z_coor(:,2),'-^','LineWidth',1) % tau xy
%ylim([h(1,1)-0.005 h(1,end)+0.005]) 
%xlim([Eps_res(end,3)-0.001 Eps_res(1,3)+0.001])
xlabel('Stress [MPa]')
ylabel('Position [mm]')
tit3=title('Stress in General Coordinate System');
lgd3=legend('\sigma_x','\sigma_y','\tau_{xy}');
lgd3.FontSize=12;
lgd3.FontWeight='bold';
tit3.FontSize=15;
tit3.FontWeight='bold';

% In material coordiantes
subplot(2,1,2);
for i=1:length(h)
    plot([min(min(Sig_res(:,3+3:5+3)))-10,max(max(abs(Sig_res(:,3+3:5+3))))+10],[h(1,i) h(1,i)],':k','LineWidth',0.8,'HandleVisibility','off'); hold on % vertical ply line
end
plot([min(min(Sig_res(:,3+3:5+3)))-15,max(max(abs(Sig_res(:,3+3:5+3))))+15],[0 0],'-.r','HandleVisibility','off'); hold on % horizontal zero line, middle plane line
plot([min(min(Sig_res(:,3+3:5+3)))-10,max(max(abs(Sig_res(:,3+3:5+3))))+10],[h(1,end) h(1,end)],'k','LineWidth',1.5,'HandleVisibility','off'); % horizontal laminate top line
plot([min(min(Sig_res(:,3+3:5+3)))-10,max(max(abs(Sig_res(:,3+3:5+3))))+10],[h(1,1) h(1,1)],'k','LineWidth',1.5,'HandleVisibility','off'); % horizontal laminate bottom line
plot([0,0],[Z_coor(end,2)-0.0015,Z_coor(1,2)+0.0015],'--r','HandleVisibility','off'); % vertical zero line
plot([min(min(Sig_res(:,3+3:5+3)))-10 ,min(min(Sig_res(:,3+3:5+3)))-10],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5,'HandleVisibility','off'); % vertical left edge line
plot([max(max(abs(Sig_res(:,3+3:5+3))))+10,max(max(abs(Sig_res(:,3+3:5+3))))+10],[Z_coor(end,2),Z_coor(1,2)],'k','LineWidth',1.5,'HandleVisibility','off'); % vertical right edge line

plot(Sig_res(:,3+3),Z_coor(:,2),'-*','LineWidth',1) % sigma 1
plot(Sig_res(:,4+3),Z_coor(:,2),'-s','LineWidth',1) % sigma 2
plot(Sig_res(:,5+3),Z_coor(:,2),'-^','LineWidth',1) % tau 12
%ylim([h(1,1)-0.005 h(1,end)+0.005]) 
%xlim([Eps_res(end,3)-0.001 Eps_res(1,3)+0.001])
xlabel('Stress [MPa]')
ylabel('Position [mm]')
tit4=title('Stress in Material Coordinate System');
lgd4=legend('\sigma_1','\sigma_2','\tau_{12}');
lgd4.FontSize=12;
lgd4.FontWeight='bold';
tit4.FontSize=15;
tit4.FontWeight='bold';
end