               %   <<Experiment-5 PART-A (8-PSK)>>
%                               << Objective-1 >>
% Aim: Simulation study of Performance of 8-PSK.
% Objective-1: Write a program to plot signal constellation diagram of received
%              8-PSK signal in the presence of AWGN.
% Objective-2: Write a program to plot Practical and Theoretical BER vs SNR graph
%              of received 8-PSK signal in the presence of AWGN for ML receiver.

% Note: For objective-2, see separate octave file named <my_8PSK_ber.m>
clc;
clear all;
close all;
pkg load communications
N = 3000;  % Number of bits to be transmitted using *-PSK
           % Too large value may slow down the program
x = randi([0,1],1,N); % Random input bits generation
M = 8;     % Number of Symbols in 8-PSK

% Symbol Generation
yy = [];
for i=1:3:length(x)
  if x(i)==0 && x(i+1)==0 & x(i+2)==0
    y = cosd(0)+1j*sind(0);
  elseif x(i)==0 && x(i+1)==0 & x(i+2)==1
    y = cosd(45)+1j*sind(45);
  elseif x(i)==0 && x(i+1)==1 & x(i+2)==1
    y = cosd(90)+1j*sind(90);
  elseif x(i)==0 && x(i+1)==1 & x(i+2)==0
    y = cosd(135)+1j*sind(135);
  elseif x(i)==1 && x(i+1)==1 & x(i+2)==0
    y = cosd(180)+1j*sind(180);
  elseif x(i)==1 && x(i+1)==1 & x(i+2)==1
    y = cosd(225)+1j*sind(225);
  elseif x(i)==1 && x(i+1)==0 & x(i+2)==1
    y = cosd(270)+1j*sind(270);
  elseif x(i)==1 && x(i+1)==0 & x(i+2)==0
    y = cosd(315)+1j*sind(315);
  endif
% Transmitted Symbols
yy = [yy y];
endfor
scatterplot(yy);    % Constellation Diagram without Noise
EbN0db = 20; % Change this value & run program to see the noisy constellation.
EbN0 = 10^(EbN0db/10);

% AWGN Channel
n = (1/sqrt(2))*[randn(1,length(yy)) + 1j*randn(1,length(yy))];
sigma = sqrt(1/((log2(M))*EbN0));

% Received Symbols
r = yy + sigma*n;
scatterplot(r);    % Constellation Diagram with Noise

