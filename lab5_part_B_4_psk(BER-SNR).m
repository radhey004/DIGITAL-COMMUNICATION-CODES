clc;
clear all;
close all;
pkg load communications

N = 3000;  % Number of bits
x = randi([0,1],1,N); % Random input bits
M = 4;     % Number of Symbols in 4-PSK (QPSK)

% Symbol Generation (Gray mapping)
yy = [];
for i=1:2:length(x)
  if x(i)==0 && x(i+1)==0
    y = cosd(45)+1j*sind(45);      % 00
  elseif x(i)==0 && x(i+1)==1
    y = cosd(135)+1j*sind(135);    % 01
  elseif x(i)==1 && x(i+1)==1
    y = cosd(225)+1j*sind(225);    % 11
  elseif x(i)==1 && x(i+1)==0
    y = cosd(315)+1j*sind(315);    % 10
  endif
  yy = [yy y];
endfor

% Reference Constellation
ref_symbols = [cosd(45)+1j*sind(45), cosd(135)+1j*sind(135), ...
               cosd(225)+1j*sind(225), cosd(315)+1j*sind(315)];

% BER Computation
ber_simulated = [];
ber_theoretical = [];

for EbN0db = 0:15
  EbN0 = 10^(EbN0db/10);

  % AWGN channel
  n = (1/sqrt(2))*[randn(1,length(yy)) + 1j*randn(1,length(yy))];
  sigma = sqrt(1/((log2(M))*EbN0));
  r = yy + sigma*n;

  % Detection (minimum Euclidean distance)
  min_dist_index = [];
  for i=1:length(r)
    Dist = [];
    for k=1:length(ref_symbols)
      dist = abs(r(i)-ref_symbols(k));
      Dist = [Dist dist];
    endfor
    [~, idx] = min(Dist);
    min_dist_index = [min_dist_index idx];
  endfor

  % Bit Estimation
  x_estimated = [];
  for i=1:length(r)
    if ref_symbols(min_dist_index(i)) == cosd(45)+1j*sind(45)
      x_estimated = [x_estimated 0 0];
    elseif ref_symbols(min_dist_index(i)) == cosd(135)+1j*sind(135)
      x_estimated = [x_estimated 0 1];
    elseif ref_symbols(min_dist_index(i)) == cosd(225)+1j*sind(225)
      x_estimated = [x_estimated 1 1];
    elseif ref_symbols(min_dist_index(i)) == cosd(315)+1j*sind(315)
      x_estimated = [x_estimated 1 0];
    endif
  endfor

  % BER Calculation
  ber_simulated = [ber_simulated sum(x ~= x_estimated)/N];

  % Theoretical BER for QPSK
  ber_theoretical = [ber_theoretical (1/log2(M)) * erfc(sqrt(log2(M)*EbN0) * sin(pi/M))];
endfor

EbN0db = 0:15;

% Plot BER
semilogy(EbN0db, ber_simulated, 'ro-', EbN0db, ber_theoretical, 'k>-');
title('BER vs Eb/N0 for 4-PSK (QPSK)');
xlabel('Eb/N0 (dB)');
ylabel('Bit Error Rate (BER)');
grid on;
legend('Simulated', 'Theoretical');
axis([0 15 10^-4 1]);

