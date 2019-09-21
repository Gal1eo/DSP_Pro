
% Reference design for EQ2300 DSP project

% Parameters
N = 21; % Number of taps in time domain
M = 512; % Points in frequency domain (must be even)

% x-axis parameters
n = 0:(N-1);
nu = 0:1/M:1-1/M;

% Time domain signal drawn randomly
x = rand(1,N);
X = fft(x,M);
P = 1/N*abs(X).^2;

% Write out full frequency responce for tex
f = fopen('stem.txt','w');
for k=1:N
    fprintf(f,'%f %f\n',n(k),x(k));
end;
fclose(f);

% Write out full frequency responce for tex
f = fopen('psd.txt','w');
for k=1:M/2+1
    fprintf(f,'%f %f\n',nu(k),max(20*log10(P(k)),-1e3));
end;
fclose(f);