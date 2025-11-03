clc;
clear all;
close all;

pkg load statistics;

x = -5:0.001:5;

figure;

subplot(2,1,1);
y1 = normpdf(x,1,0.5);
plot(x,y1, 'linewidth', 1);
xlabel('x');
ylabel('pdf');
title('Normal Distribution PDF for mean = 1 and std dev =0.5');
grid on;
set(gca,'xtick',-5:1:5);
