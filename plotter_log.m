% close all
figure(618);

% plot spectral evolution as a pseudocolor map
subplot(5,5,[7 8 12 13 17 18 22 23]);             
pcolor(WL(iis), 1000*Z, lIW(:,iis)); % plot as pseudocolor map
caxis([mlIW-40.0, mlIW]);  xlim([xmin,xmax]); ylim([0 flength*1000]); shading interp; colormap gray, set(gca,'fontsize',16)
box on, set(gca,'LineWidth',2)
a = gca;
b = copyobj(a, gcf);
set(b, 'Xcolor', [1 1 1], 'YColor', [1 1 1], 'XTickLabel', [], 'YTickLabel', [])
set(b,'XTickLabel',[]);
set(b, 'Layer', 'top')
set(gca,'YTickLabel',[]);
xlabel('Wavelength (nm)','Color',[0 0 0]);

% plot temporal evolution as a pseudocolor map
subplot(5,5,[9 10 14 15 19 20 24 25]);
pcolor(1000*T, 1000*Z, lIT);
caxis([mlIT-40.0, mlIT]); xlim([-400,1200]); ylim([0 flength*1000]); shading interp; colormap gray, set(gca,'fontsize',16)
box on, set(gca,'LineWidth',2)
a = gca;
b = copyobj(a, gcf);
set(b, 'Xcolor', [1 1 1], 'YColor', [1 1 1], 'XTickLabel', [], 'YTickLabel', [])
set(b,'XTickLabel',[]);
set(b, 'Layer', 'top')
set(gca,'YTickLabel',[]);
xlabel('Delay (fs)','Color',[0 0 0]);

% plot cut
index = length(Z); plot_cut_log(index,Z,WL,iis,lIW,T,lIT,radius,flength,xmin,xmax,tmin,tmax,WRITE)

% figure size and background color
set(gcf, 'Position', get(0,'Screensize'));
set(gcf, 'Color', [1 1 1])