% Overlays fiber zero-dispersion wavelength on top of spectral evolution color map

% Pre-allocation
a = zeros(1,length(Z)); ZDW = zeros(1,length(Z));

% compute local fiber core size
for i = 1:length(Z)
    a(i) = build_fiber(Z(i), d0, dw, Lt1, Lt2, Lw, L0);
end

% unpack ZDW data (pre-computed)
cd saved, load('zdw.mat'); cd ..

% interpolate to local fiber core size
for i = 1:length(Z)
    ZDW(i) = interp1(av,zdwv,a(i),'spline');
end

plot(ZDW,1000*Z,'k','LineWidth',2,'LineStyle',':')
