% close all
figure(617);

% plot spectral evolution as a pseudocolor map
subplot(4,4,[6 7 8 10 11 12 14 15 16]);             
pcolor(WL(iis), 1000*Z, lIW(:,iis));
caxis([mlIW-40.0, mlIW]);  xlim([xmin,xmax]); ylim([0 flength*1000]); shading interp; colormap copper
xlabel('Wavelength  (nm)','FontSize',16);
hcb = colorbar; hcb.Label.String = 'Intensity (dB)'; hcb.FontSize = 16;
set(gca,'fontsize',16)

% title string capturing current laser and fiber parameters
tstring1 = ['$\lambda_0$ = ' num2str(lp,'%3.0f') ' nm, '...
num2str(pwidth) ' fs FWHM, ' num2str(penergy) ' pJ/pulse'];

tstring2 = ['$d_0$ = ' num2str(d0,'%1.2f') ' $\mu$m, '...
'$d_w$ = ' num2str(dw,'%1.2f') ' $\mu$m, '...
'$L_0$ = ' num2str(1000*L0,'%1.2f') ' mm, '...
'$L_{t_{1}}$ = ' num2str(1000*Lt1,'%1.1f') ' mm, '...
'$L_w$ = ' num2str(1000*Lw,'%1.1f') ' mm, '...
'$L_{t_{2}}$ = ' num2str(1000*Lt2,'%1.1f') ' mm, '...
'$L_1$ = ' num2str(1000*L1,'%1.1f') ' mm'];

title([tstring1 ', ' tstring2], 'FontSize',12,'Interpreter','LaTeX')

% plot cut
index = length(Z); plot_cut_lin(index,Z,WL,iis,lIW,radius,flength,xmin,xmax,WRITE)

% slider GUI
slmin = 1; slmax = length(Z);
hsl = uicontrol('Style','slider','Min',slmin,'Max',slmax,...
                'SliderStep',[2 2]./(slmax-slmin),'Value',slmax,...
                'Position',[200 800 350 20]);
set(hsl,'Callback',@(hObject,eventdata) plot_cut_lin(round(get(hObject,'Value')),Z,WL,iis,lIW,radius,flength,xmin,xmax,0))

% figure size
set(gcf, 'Position', get(0,'Screensize'));