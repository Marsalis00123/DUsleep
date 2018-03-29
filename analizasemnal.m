%%
load('semnal1.mat');
s=semnal1;

% load('semnal2.mat');
% s=semnal2;

L=length(s);
fs=50;
fc=1;
T=L*(1/fs);
t=0:T/L:T-(T/L);
figure,plot(t,s)
nfft=2^nextpow2(L);
y=fft(s,nfft)/L;
f=fs/2*linspace(0,1,nfft/2+1);
figure,plot(f,2*abs(y(1:nfft/2+1))),title('FFT Semnal')
w0=fc/((fs/2));
bw=w0/35;
[num]=fir1(50,w0);
fvtool(num)
filtrat=filter(num,1,s);
figure
plot(t,filtrat)
%%
%eliminare zerouri
z=zeros(1,L);
j=1;
for i=1:L
    n=0;
    suma=0;
    while (s(i)>0)
        suma=suma+s(i);
        n=n+1;
        if(i==L)
            break,end
        i=i+1;
    end
    if(suma>0)
        z(j)=suma/n;
        j=j+1;
    end
end
zscurt=z(1:j-1);
tscurt=t(1:j-1);
figure,
plot(tscurt,zscurt)        
        
%%
%analiza fourier z
L2=length(zscurt);
fs2=50;
fc2=0.1;
T2=L2*(1/fs2);
t2=0:T2/L2:T2-(T2/L2);
figure,plot(t2,zscurt)
nfft2=2^nextpow2(L2);
y2=fft(zscurt,nfft2)/L2;
f2=fs2/2*linspace(0,1,nfft2/2+1);
figure,plot(f2,2*abs(y2(1:nfft2/2+1))),title('FFT Semnal')
%%
%fir 1 trece jos
w02=fc2/((fs2/2));
bw2=w02/35;
[num2]=fir1(120,w02);
fvtool(num2)
filtrat2=filter(num2,1,zscurt);
figure
plot(t2,filtrat2)        
        
%%
%filtru bandpass
fcs2=0.01;
fcd2=0.015;
w02s=fcs2/((fs2/2));
w02d=fcd2/((fs2/2));
bw2=w02/35;
[num2]=fir1(150,[w02s w02d]);
fvtool(num2)
filtrat2=filter(num2,1,zscurt);
figure
plot(t2,filtrat2)        
