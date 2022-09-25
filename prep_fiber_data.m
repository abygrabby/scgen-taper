% Prepare fiber data from dispersion and effective area calculations
% performed in Lumerical

cd fiber

c = 299792458;  
m = length(1.2:0.05:2.8);   % number of directories in "fiber"
n = length(W);              % number of frequency points
DISP = zeros(m,n);          % initialize dispersion operator
NEFF = zeros(m,n);          % initialize effective index 
AEFF = zeros(m,n);          % initialize effective area
a = zeros(m,1);             % initialize core radius

for i = 1:m
    % navigate to the directory for each core size
    dirname = 1.2+(i-1)*0.05;
    cd(num2str(dirname,'%1.2f'));
    
    % unpack data
    load('sweep_data.mat');
    w = 2*pi*f/1e12;
    dW = W(2)-W(1);
 
    % interpolate to points on frequency grid or compute related quantities
    NEFFi = interp1(w,neff,W,'spline');
    AEFFi = interp1(w,area,W,'spline');
    BETA = NEFFi.*W/c*1e12;
    BETA0 = interp1(W,BETA,w0);
    BETA1 = gradient(BETA,dW);
    BETA1WP = interp1(W,BETA1,wp);

    DISP(i,:) = BETA - BETA0 - BETA1WP*V;       % compute disp. operator & store
    NEFF(i,:) = NEFFi.';                        % store effective index
    AEFF(i,:) = AEFFi.';                        % store effective area
    a(i) = dirname/2;                           
    
    cd ..
end

a=a';

cd ..
% write to file
save('fiber_data','DISP','NEFF','AEFF','a')