close all;
clear all;
%% initial values
Fs = 16000;
N1 = 1000;
n =1:1:N1;


f1 = 1000;
f2 = 1075;
f3 = 975;
s1 = [sin(2*pi*f1/Fs*(1:405)) sin(2*pi*f2/Fs*(406:805)) sin(2*pi*f3/Fs*(806:1000))];
s2 = [0.5*cos(2*pi*2*f1/Fs*(1:405)) 0.5*cos(2*pi*2*f2/Fs*(406:805)) 0.5*cos(2*pi*2*f3/Fs*(806:1000))];
s3 = [-0.25*cos(2*pi*3*f1/Fs*(1:405)) 0.25*cos(2*pi*3*f2/Fs*(406:805)) 0.25*cos(2*pi*3*f3/Fs*(806:1000))];
s = s1+s2+s3;
s = s + awgn(s,36,'measured');

r1 = 0.95;
r2 = 0.85;
mu = 0.0001;
M = 3;
iteration = 1000;