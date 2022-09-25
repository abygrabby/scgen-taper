lp = 800;                               % pump (carrier) wavelength (nm)
c = 299792458*1e9/1e12;                 % speed of light [nm/ps]
wp = 2*pi*c/lp;                         % pump (carrier) frequency [2*pi*THz]
penergy = 215;                          % pulse energy in pJ

% === sech input pulse
% pwidth = 19.5;                          % FWHM in fs
% t0 = (pwidth/1.76)*1e-3;                % characteristic timescale of input [ps]
% power = 0.88*penergy/pwidth*1e3;        % peak power of input [W]
% A = sqrt(power)*sech(T/t0).*exp(1i*(w0-wp)*T); % input field [W^(1/2)]

% === Gaussian input pulse
pwidth = 27;                            % FWHM in fs
t0 = pwidth*1e-3;                       % FWHM in ps
power = 0.94*penergy/t0;                % peak power of input [W]
A = sqrt(power)*exp(-2*log(2)*(T/t0).^2).*exp(1i*(w0-wp)*T); % input field [W^(1/2)]

% === Fiber geometry (see arXiv:1807.07857 for notation, lengths in metres,
% diameters in micrometres)
L0 = 0.00005; d0 = 2.80;
Lt1 = 0.0055; dw = 1.50;
Lt2 = Lt1;
Lw = 0.0009;
L1 = 0.0215-(L0 + Lt1 + Lw + Lt2);
flength = L0 + Lt1 + Lw + Lt2 + L1;     % total fiber length [m]

% Prepare fiber data file if it does not exist
if exist(fullfile(cd, 'fiber_data.mat'), 'file') ~=2
end
prep_fiber_data

% === Fiber parameters
% Load fiber data and extract dispersion operator, effective index,
% effective area and fiber diameter
load('fiber_data.mat')
fdata1 = DISP;
fdata2 = NEFF;
fdata3 = AEFF;
fdata4 = a;
loss = 0;                               % loss [dB/m]
n2 = 2.5e-20;                           % nonlinear refractive index [m^2/W]

% === Raman response
fr = 0.18;                              % fractional Raman contribution
tau1 = 0.0122; tau2 = 0.032;            % Raman fit parameters
RT = (tau1^2+tau2^2)/tau1/tau2^2*exp(-T/tau2).*sin(T/tau1); % Raman response function
RT(T<0) = 0;                            % heaviside step function
%RT = RT/trapz(T,RT);                   % normalise RT to unit integral

NOISE = 0;                              % turn off noise
WRITE = 0;                              % turn off saving output spectrum to file
plot_toggle = 1;                        % turn on plotting
plot_style = 'LIN';                     % use linear y-scale for spectral cuts, launch interactive GUI