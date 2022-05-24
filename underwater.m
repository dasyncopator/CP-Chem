air125 = readtable('C:\Users\Tanay Mannikar\OneDrive - The University of Texas at Austin\CP Chem\Pipe Classification\Underwater Scat\Chirp1\Air-filled\0.125inch\scattered.txt', 'Format', '%f%f', 'HeaderLines', 5);
air25 = readtable('C:\Users\Tanay Mannikar\OneDrive - The University of Texas at Austin\CP Chem\Pipe Classification\Underwater Scat\Chirp1\Air-filled\0.25inch\scattered2.txt', 'Format', '%f%f', 'HeaderLines', 5);
water125 = readtable('C:\Users\Tanay Mannikar\OneDrive - The University of Texas at Austin\CP Chem\Pipe Classification\Underwater Scat\Chirp1\Water-filled\0.125inch\scattered.txt', 'Format', '%f%f', 'HeaderLines', 5);
water25 = readtable('C:\Users\Tanay Mannikar\OneDrive - The University of Texas at Austin\CP Chem\Pipe Classification\Underwater Scat\Chirp1\Water-filled\0.25inch\scattered.txt', 'Format', '%f%f', 'HeaderLines', 5);

tiledlayout(4,1);

L = 25000;
Fs = 1 / 6.4e-7;
x1 = water25{:,1};
y1 = water25{:,2} + 0.00185;
x2 = air25{:,1};
y2 = air25{:,2} + 0.00185;
x3 = water125{:,1};
y3 = water125{:,2} + 0.00185;
x4 = air125{:,1};
y4 = air125{:,2} + 0.00185;

%.*blackmanharris(length(round(L/9)))
win = cat(1, blackmanharris(round(3*L/10)), zeros(round(7*L/10), 1));
y1_win = lowpass(y1, 0.01).*win;
y1_fil = lowpass(y1_win, 0.01);
y2_win = lowpass(y2, 0.01).*win;
y2_fil = lowpass(y2_win, 0.01);
y3_win = lowpass(y3, 0.01).*win;
y3_fil = lowpass(y3_win, 0.01);
y4_win = lowpass(y4, 0.01).*win;
y4_fil = lowpass(y4_win, 0.01);

% ax0 = nexttile;
% plot(x1, y1_fil)
% ax1 = nexttile;
% plot(x2, y2_fil)
% ax2 = nexttile;
% plot(x3, y3_fil)
% ax3 = nexttile;
% plot(x4, y4_fil)
% linkaxes([ax0 ax1 ax2 ax3],'xy')

Y1 = fft(y1_fil);
Y2 = fft(y2_fil);
Y3 = fft(y3_fil);
Y4 = fft(y4_fil);

P2 = abs(Y1/L);
P3 = abs(Y2/L);
P21 = abs(Y3/L);
P31 = abs(Y4/L);

P1 = P2(1:L/2+1);
P4 = P3(1:L/2+1);
P11 = P21(1:L/2+1);
P41 = P31(1:L/2+1);

P1(2:end-1) = 2*P1(2:end-1);
P4(2:end-1) = 2*P4(2:end-1);
P11(2:end-1) = 2*P11(2:end-1);
P41(2:end-1) = 2*P41(2:end-1);

f = Fs*(0:(L/2))/L;

% ax4 = nexttile;
% plot(f(1:2000), log10(P1(1:2000)))
% ax5 = nexttile;
% plot(f(1:2000), log10(P4(1:2000)))
% ax6 = nexttile;
% plot(f(1:2000), log10(P11(1:2000)))
% ax7 = nexttile;
% plot(f(1:2000), log10(P41(1:2000)))
% linkaxes([ax4 ax5 ax6 ax7],'xy')

c1 = real(ifft(log10(P1(1:2000))));
c2 = real(ifft(log10(P4(1:2000))));
c3 = real(ifft(log10(P11(1:2000))));
c4 = real(ifft(log10(P41(1:2000))));
ax7 = nexttile;
plot(x1(1:2000), log10(abs(c1)))
ax8 = nexttile;
plot(x2(1:2000), log10(abs(c2)))
ax9 = nexttile;
plot(x3(1:2000), log10(abs(c3)))
ax10 = nexttile;
plot(x4(1:2000), log10(abs(c4)))
linkaxes([ax7 ax8 ax9 ax10],'xy')
