%   <<Experiment-5 PART-B (4-PSK)>>
%   Objective: Simulation study of Performance of 4-PSK.
%   Objective-1: Plot signal constellation diagram of received 4-PSK signal in presence of AWGN.
%   Objective-2: Plot BER vs SNR (theoretical + practical) -> see separate file if needed.

clc;
clear all;
close all;
pkg load communications

N = 3000;  % Number of bits
x = randi([0,1],1,N); % Random input bits
M = 4;     % Number of Symbols in 4-PSK

% Symbol Generation (Gray mapping for QPSK)
yy = [];
for i=1:2:length(x)
  if x(i)==0 && x(i+1)==0
    y = cosd(45)+1j*sind(45);     % 00
  elseif x(i)==0 && x(i+1)==1
    y = cosd(135)+1j*sind(135);   % 01
  elseif x(i)==1 && x(i+1)==1
    y = cosd(225)+1j*sind(225);   % 11
  elseif x(i)==1 && x(i+1)==0
    y = cosd(315)+1j*sind(315);   % 10
  endif
  yy = [yy y];
endfor

% Constellation without noise
figure;
scatterplot(yy);
title('4-PSK Constellation (No Noise)');

% AWGN Channel
EbN0db = 15;   % SNR in dB (try 5, 10, 15, 20)
EbN0 = 10^(EbN0db/10);
n = (1/sqrt(2))*[randn(1,length(yy)) + 1j*randn(1,length(yy))];
sigma = sqrt(1/((log2(M))*EbN0));

% Received symbols
r = yy + sigma*n;

% Constellation with noise
figure;
scatterplot(r);
title(['4-PSK Constellation with AWGN (Eb/N0 = ', num2str(EbN0db), ' dB)']);

