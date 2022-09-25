% Function to to plot cuts of the spectral and temporal evolution (log scale)

function output = plot_cut_log(index,Z,WL,iis,lIW,T,lIT,radius,flength,xmin,xmax,tmin,tmax,WRITE)

disp(['Cut: ' num2str(1000*Z(index),'%2.2f') ' mm'])        % display current position

wl = WL(iis);                                               % subset of wavelengths
outspec = 10.^(lIW(index,iis)/10)/1e4;                      % output spectrum
inspec = 10.^(lIW(1,iis)/10)/1e4;                           % input spectrum

% Write output spectrum to file
if WRITE
    save('spectrum','wl','outspec')
end

outpulse = 10.^(lIT(index,:)/10);                           % output time domain field
outpulse = outpulse/max(outpulse);                          % normalization

% Plot the spectral domain cut
subplot(5,5,[2 3]);
hold on, xlim([xmin xmax]), ylim([-30 2])
semilogy(wl,10*log10(outspec/max(outspec)),'r','LineWidth',2)
set(gca,'fontsize',16)
ylabel({'Intensity','(10 dB/div)'})
set(gca,'YTickLabel',[])
set(gca, 'XAxisLocation', 'top')
box on
set(gca,'LineWidth',2)

% Plot the time domain cut
subplot(5,5,[4 5])
plot(1000*T, 10*log10(outpulse),'r','LineWidth',2)
xlim([tmin,tmax]); ylim([-30 2])
set(gca,'YTickLabel',[])
set(gca,'fontsize',16)
set(gca, 'XAxisLocation', 'top')
box on
set(gca,'LineWidth',2)  

% Plot the fiber geometry
subplot(5,5,[6 11 16 21]);
plot(radius,1000*Z,'r','LineWidth',2), hold on
plot(-radius,1000*Z,'r','LineWidth',2)
plot(zeros(size(Z)),1000*Z,'r--','LineWidth',2), hold off
set(gca,'fontsize',16)
ylabel('Distance (mm)');
xlabel('Core size (µm)')
ylim([0 flength*1000])
xlim([-4 4])
set(gca,'LineWidth',2)

end