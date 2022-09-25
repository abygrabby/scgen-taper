% Seed input field with shot noise for coherence calculation

hbar = 1.0545718e-34; % reduced Planck's constant in J*s
Ar = real(A); % real part of input field
Ai = imag(A); % imaginary part of input field

% Noise generated as described in PRA 84, 011806 (2011).
Arn = normrnd(0,sqrt(hbar*(wp*1e12)/(4*dT*1e-12)),1,n);
Ain = normrnd(0,sqrt(hbar*(wp*1e12)/(4*dT*1e-12)),1,n);

% Add noise
Ar = Ar + Arn;
Ai = Ai + Ain;

% Recombine parts into a complex field
A = Ar + 1i*Ai;