clc;
clear;

fs = 100e3;
fc = 10e3;
t0 = -5;
tf = 5;
ts = 1/fs;
t = t0 : ts : tf;
fm = 10;
ac = 1;
kf = 100;

m = cos(2*pi*fm*t);
m_int = (1/(2*pi*fm)) * sin(2*pi*fm*t);

xc = ac * cos(2*pi*fc*t + 2*pi*kf*m_int);


figure(1);
subplot(221); 
plot(t , m , 'LineWidth' , 2);
xlabel('t(s)');
ylabel('m(t)');
title('message signal');
legend('m(t)');
xlim([-1 1]);

figure(1);
subplot(222); 
FFT(m , fs); 
xlim([-20 20]);

figure(1);
subplot(223) 
plot(t, xc , 'LineWidth' , 2);
xlabel('t(s)');
ylabel('xc(t)');
title('modulated signal');
legend('xc(t)');
xlim([-500e-6 , 500e-6]);

figure(1);
subplot(224); 
FFT(xc , fs);
xlim([10e3-200 10e3+200]);


%demodulation

xc(end+1) = xc(end);

dxc = diff(xc) / ts;
edxc = abs(hilbert(dxc));
m_final = (1/kf)*((edxc/(ac*2*pi)) - fc);

figure(2);
plot(t, m_final);
xlabel('t(s)');
ylabel('m_modulated(t)');
title('demodulated signal');
legend('m_modulated(t)');
xlim([-1 , 1]);

