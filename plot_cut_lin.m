% Function to to plot cuts of the spectral evolution (linear scale)

function output = plot_cut_lin(index,Z,WL,iis,lIW,radius,flength,xmin,xmax,WRITE)

disp(['Cut: ' num2str(1000*Z(index),'%2.2f') ' mm'])        % display current position

wl = WL(iis);                                               % subset of wavelengths
outspec = 10.^(lIW(index,iis)/10)/1e4;                      % output spectrum
inspec = 10.^(lIW(1,iis)/10)/1e4;                           % input spectrum

% Write output spectrum to file
if WRITE
    save('spectrum','wl','outspec')
end

% Plot the cut
subplot(4,4,[2 3 4]);
hold on, xlim([xmin xmax]), %ylim([0 4*avg])
plot(wl,outspec,'b','LineWidth',2)
ylabel('Intensity (linear, arb.)','FontSize',16)
set(gca,'fontsize',16)
set(gca, 'XAxisLocation', 'top')
box on
colorbar, c = colorbar; set(c, 'Visible', 'off')
text(-100, 0, ['Cut: ' num2str(1000*Z(index),'%2.2f') ' mm'],'fontsize',16)

% Plot the fiber geometry with the cut overlaid
subplot(4,4,[5 9 13]);
plot(radius,1000*Z,'r','LineWidth',2), hold on
plot(-radius,1000*Z,'r','LineWidth',2)
plot(zeros(size(Z)),1000*Z,'r--','LineWidth',2), hold off
xlabel('Core size (µm)','FontSize',16)
ylabel('Distance (mm)','FontSize',16)
ylim([0 flength*1000])
xlim([-4 4])
line([-4 4],[1000*Z(index) 1000*Z(index)],'Color','b','LineWidth',2)
set(gca,'fontsize',16)

end