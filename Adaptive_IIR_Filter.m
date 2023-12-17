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

%% functions
function [f,b,a] =  notchFilter(r,theta,M,s)
    bIIR = [1 -2*cos(1*theta) 1];
    aIIR = [1 -2*r*cos(1*theta) r^2];
    f{1}  = filter(bIIR,aIIR,s);
    b = bIIR;
    a = aIIR;


    for m = 2:M
        bIIR = [1 -2*cos(m*theta) 1];
        aIIR = [1 -2*r*cos(m*theta) r^2];
        f{m} = filter(bIIR,aIIR,f{m-1});
        b = conv(b,bIIR);
        a = conv(a,aIIR);
        
    
    end 
    

end

function mse =  mseMaker(y,M)
    for i = 1:M  
        mse(i) = mean(y{i}.^2);    
    end
end

function [MSE, MSE1, MSEaverage, freq] =  mseCalculator(r,M,s,iteration)
    theta = linspace(0,pi/M,iteration);
    freq = theta/pi;
    for i = 1:length(theta)
        y = notchFilter(r,theta(1,i),M,s);
        x = mseMaker(y,M);
        MSE(i) = x(M);
        MSE1(i) = x(1);
    end
    MSEaverage = mean(MSE)*ones(length(theta));
    
end

function msePlotter(mse, mse1, mseAverage,globalMinX,globalMinY, freq)
    fCaptureIndex = freqCaptureCal(mse,mseAverage);
    figure;
    plot(freq, mse, 'k');
    hold on;
    plot(freq, mse1, '--');
    plot(freq, mseAverage, 'r--');
    plot(freq(1, fCaptureIndex(1)), mse(fCaptureIndex(1)), 'ro');
    plot(freq(1, fCaptureIndex(2)), mse(fCaptureIndex(2)), 'ro');
    plot(globalMinX, globalMinY, 'ro')
    xlabel('Frequency (Hz)');
    ylabel('MSE');
    legend(["MSE" "MSE1" "Average MSE"], "location", "south")
    
    

end


function theta =  lmsCal(M,mu,theta,s,r,N1)
    
    for i = 3:N1
        
        f = notchFilter(r,theta(1,i),M,s);
        
        for k = 1:M
            y{k+1} = f{k};
        end
        
        y{1} = s;
        beta{1} = zeros(1,1000);  
        
        for m = 1:M
                         
          beta{m+1}(1,1) = 0;
          beta{m+1}(1,2) = 0;  
          
        
          for n = 3:N1

            beta{m+1}(1,n) = beta{m}(1,n) - 2*cos((m)*theta(1,n))*beta{m}(1,n-1)  ...
            + 2*(m)*sin((m)*theta(1,n))*y{m}(1,n-1) + beta{m}(1,n-2) ...
             + 2*r*cos((m)*theta(1,n))*beta{m+1}(1,n-1) -r^2*beta{m+1}(1,n-2) ...
            - 2*r*(m)*sin((m)*theta(1,n))*y{m+1}(1,n-1);
            
        
          end   
           
        end
              
        theta(1,i+1) = theta(1,i)-2*mu*y{M}(1,i)*beta{M}(1,i);

    end
    
    
end

function thetaOpt = thetaOptimumCal(r,M,s,iteration,mse_flag_plot,Fs)

[mse,mse1, mseAvg, freq] = mseCalculator(r,M,s,iteration);
disp(size(mse))

[ymins, xmins] = findpeaks(-mse,freq);
ymin = ymins*-1;
[ymin,index] = min(ymin);
xmin = xmins(index);
thetaOpt = xmin*pi;
globalMinX = (xmin*Fs/2);
globalMinY = ymin;

if (mse_flag_plot)
    msePlotter(mse,mse1,mseAvg,globalMinX,globalMinY, freq*Fs/2); 
end