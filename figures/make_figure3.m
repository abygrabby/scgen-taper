ext_param = 1;

cd ..
% load defaults
default_config
default_param
plot_style = 'LOG'; % overwrite plot style

simulate_tapered_pcf

subplot(5,5,[7 8 12 13 17 18 22 23]); hold on; plot_ZDW;
text(410,21.1,'(b)','Color','w','FontSize',18,'FontWeight','bold')

subplot(5,5,[2 3]); yyaxis right
cd saved, load('coherence_gauss.mat'); cd ..
plot(WL,G12,'.')
ylim([0 1.2])
text(1120,0.95,'|{\it g}_{12}^{(1)}|','FontSize',14,'Color',[0 0.4470 0.7410],'BackgroundColor','w')
yyaxis left
set(gca,'ycolor','r')
text(410,-.5,'(c)','Color','k','FontSize',18,'FontWeight','bold')

subplot(5,5,[4 5])
set(gca,'ycolor','r')
text(-390,-.5,'(e)','Color','k','FontSize',18,'FontWeight','bold')

g = subplot(5,5,[9 10 14 15 19 20 24 25]);
pos = get(g,'Position');
colorbar
hcb = colorbar; hcb.Label.String = 'Intensity (dB)'; hcb.FontSize = 16; hcb.TickLabels=[5:5:40];
set(g,'Position',pos)
text(-390,21.1,'(d)','Color','w','FontSize',18,'FontWeight','bold')
text(1400,0,'0','Color','k','FontSize',16)

subplot(5,5,[6 11 16 21]);
text(-3.8,21.1,'(a)','Color','k','FontSize',18,'FontWeight','bold')
text(0,0.4,'INPUT','Color','k','FontSize',14,'FontWeight','bold','HorizontalAlignment','center')
text(0,21.1,'OUTPUT','Color','k','FontSize',14,'FontWeight','bold','HorizontalAlignment','center')

clear('ext_param')