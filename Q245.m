Fs = 48;  % Sampling Frequency khz

N    = 48;       % Order
Fc   = 3;        % Cutoff Frequency khz
flag = 'scale';  % Sampling Flag

% Create the window vector for the design algorithm.
win = hamming(N+1);

% Calculate the coefficients using the FIR1 function.
hn  = fir1(N, Fc/(Fs/2), 'low', win, flag);
Hd = dfilt.dffir(hn);
digit=12;
Amp=power(2,digit);
d=int16(hn*Amp);
hqn=double(d)/Amp;
figure
freqz(hn)
title('Frequency response of the original filter')
figure
freqz(hqn)
title('Frequency response of the quantized filter')
RD=(rand(1,10000)-0.5).*(2^-10);% range -0.5*2^-10~0.5*2^-10
XL=filter(hn,1,RD);XLQ=filter(hqn,1,RD);% XL: exact filtered signal
temp=int16(XLQ.*(2^16));
SQNR=mean(XL.*XL)/mean((XL-XLQ).*(XL-XLQ));
%Question 3
mid=N/2+1;
h3n=-hn;
h3n(mid)=h3n(mid)+1;
figure
freqz(h3n)
title('Frequency response of the High-Pass filter')

t=0:N;
stem(t,hn)
title('Impulse response of the original filter')
stem(t,hqn)
title('Impulse response of the quantized filter')
stem(t,h3n)
title('Impulse response of the High-Pass filter')