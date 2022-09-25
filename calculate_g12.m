% Script to calculate first-order coherence of supercontinuum

ext_param = 1;                  % turn on external parameters
default_config;                 % load default configuration
default_param;                  % load default parameters
NOISE = 1;                      % turn on noise
plot_toggle = 0;                % turn off plotting

runs = 100;                     % number simulation iterations              
Aout = zeros(runs,n);           % initialize output field
num = zeros(1,n);               % initialize numerator of Eq. (2) in arXiv:1807.07857
den = zeros(1,n);               % initialize denominator 

for i = 1:runs
    simulate_tapered_pcf;       % run simulation
    disp(i)                     % show how many iterations are complete
    Aout(i,:) = AW(end,:);      % store output field from current iteration
end

% Do ensemble average for numerator
count = 0;
for i = 1:runs
    for j = 1:runs
        if i~=j
            num = num + conj(Aout(i,:)).*Aout(j,:);
            count = count+1;
        end
    end
end
num = abs(num/count);

% Do ensemble average for denominator
for i = 1:runs
    den = den + abs(Aout(i,:)).^2;
end
den = den/runs;

% Compute ratio
G12 = num./den;

% Plot coherence vs. wavelength
plot(WL,G12,'k.','LineWidth',2)
xlim([min(WL) max(WL)])
ylim([0 1.2])
set(gca,'FontSize',16)
set(gca,'LineWidth',2)
xlabel('Wavelength (nm)')
ylabel('|{\it g}_{12}^{(1)}|');
set(gcf, 'Color', 'w')

% save('coherence','WL','G12') % save computed correlation function (optional)

clear('ext_param')