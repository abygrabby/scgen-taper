% GNLSE solver for tapered fibers, modified from script available at http://scgbook.info/
% See Chapter 3 of the book
% J. M. Dudley and J. R. Taylor, "Supercontinuum Generation in Optical Fibers," Cambridge University Press, 2010
% for more details.

function [Z, AT, AW, W] = gnlse_taper(T, A, w0, wp, loss, fr, RT, flength, nsaves, d0, dw, Lt1, Lt2, Lw, L0, fdata1, fdata2, fdata3, fdata4, n2)

n = length(T); dT = T(2)-T(1); % grid parameters
V = 2*pi*(-n/2:n/2-1)'/(n*dT); % frequency grid
alpha = log(10.^(loss/10));    % attenuation coefficient
 
W = V + w0;                    % for shock W is true freq  
RW = n*ifft(fftshift(RT.'));   % frequency domain Raman
W = fftshift(W);               % shift to fft space

% === define function to return the RHS of Eq. (1) in arXiv:1807.07857
function R = rhs(z, AW, d0, dw, Lt1, Lt2, Lw, L0, fdata1, fdata2, fdata3, fdata4, w0, wp, n2)
  c = 299792458/1e12;                               % speed of light [nm/ps]
  a = build_fiber(z, d0, dw, Lt1, Lt2, Lw, L0);     % local fiber core radius
  X = fdata1;                                       % unpack dispersion operator
  av = fdata4;                                      % unpack core radius vector
  B = interp1(av,X,a).';                            % intepolate to local core radius
  
  % construct linear operator and shift to fft space
  L = 1i*B - alpha/2;                               
  L = fftshift(L);

  % unpack effective index, intepolate to local core radius and shift to fft space
  Y = fdata2;
  n_eff = interp1(av,Y,a).';
  n_eff0 = interp1(V+w0,n_eff,w0);
  n_eff = fftshift(n_eff);
  
  % unpack effective area, intepolate to local core radius and shift to fft space
  U = fdata3;
  A_eff = interp1(av,U,a).';
  A_eff = fftshift(A_eff);
  
  AT = fft(AW.*exp(L*z)./(A_eff).^(1/4));           % time domain field
  IT = abs(AT).^2;                                  % time domain intensity
  if (length(AT) == 1) || (abs(fr) < eps)           % no Raman case
    M = ifft(AT.*IT);                               % response function
  else
    RS = dT*fr*fft(ifft(IT).*RW);                   % Raman convolution
    M = ifft(AT.*((1-fr).*IT + RS));                % response function
  end

  gamma = n2*n_eff0.*W./(c*n_eff.*(A_eff).^(1/4));  % frequency-dependent nonlinear parameter
  R = 1i*gamma.*exp(-L*z).*M;                       % full RHS of Eq. (1) in arXiv:1807.07857
end

% === define function to print ODE integrator status
function status = report(z, ~, flag) % 
  status = 0;
  if isempty(flag)
    fprintf('%05.1f %% complete\n', z/flength*100);
  end
end
% === setup and run the ODE integrator
Z = linspace(0, flength, nsaves);  % select output z points
% === set error control options
options = odeset('RelTol', 1e-5, 'AbsTol', 1e-12, ...
                 'NormControl', 'on', ...
                 'OutputFcn', @report);
[Z, AW] = ode45(@(z, AW) rhs(z, AW, d0, dw, Lt1, Lt2, Lw, L0,...
                    fdata1, fdata2, fdata3, fdata4, w0, wp, n2), Z, ifft(A), options); % run integrator
% === process output of integrator
AT = zeros(size(AW(1,:)));
for i = 1:length(AW(:,1))
  a = build_fiber(Z(i), d0, dw, Lt1, Lt2, Lw, L0); % compute core radius at save point
  % unpack fiber data and rebuild dispersion operator
  X = fdata1;
  av = fdata4;
  B = interp1(av,X,a).';
  
  % construct linear operator and shift to fft space
  L = 1i*B - alpha/2;
  L = fftshift(L);
  
  AW(i,:) = AW(i,:).*exp(L.'*Z(i)); % change variables
  AT(i,:) = fft(AW(i,:));           % time domain output
  AW(i,:) = fftshift(AW(i,:))./dT;  % scale
end
W = V + w0; % the absolute frequency grid
end