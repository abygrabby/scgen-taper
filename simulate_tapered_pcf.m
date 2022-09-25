tic

% Initialize default configuration, if no external configuration is specified
% Set ext_config to 1 and define all quantities in default_config youself if you intend to use a different configuration
if ~exist('ext_config','var')
    default_config    
end

% Load default laser and fiber parameters, if no external parameters are specified
% Set ext_param to 1 and define all quantities in default_param if you intend to use different parameters
if ~exist('ext_param','var')
    default_param    
end

% Add noise to input field (optional)
if NOISE
    add_shot_noise
end

% Run solver
nsaves = 200;     % number of length steps to save field at
% propagate field
[Z, AT, AW, W] = gnlse_taper(T, A, w0, wp, loss, fr, RT, flength, nsaves, d0, dw, Lt1, Lt2, Lw, L0, fdata1, fdata2, fdata3, fdata4, n2);

% Plot output
lIW = 10*log10(abs(AW).^2); % log scale spectral intensity
mlIW = max(max(lIW));       % max value, for scaling plot
c = 299792458*1e9/1e12;     % speed of light [nm/ps]
WL = 2*pi*c./W; iis = (WL>xmin & WL<xmax); % wavelength grid
% rebuild core radius vector
radius = zeros(size(Z));
for k = 1:length(Z)
    radius(k) = build_fiber(Z(k), d0, dw, Lt1, Lt2, Lw, L0);
end
lIT = 10*log10(abs(AT).^2); % log scale temporal intensity
mlIT = max(max(lIT));       % max value, for scaling plot

% Launch plotters according to pre-specified options
if plot_toggle
    if sum(plot_style == 'LIN') == 3
        plotter_lin
    elseif sum(plot_style == 'LOG') == 3
        plotter_log
    end
end

toc