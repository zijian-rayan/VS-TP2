clc;
clear;
close all;
%% flot optique

N=600;

imgDir  = dir(['*.jpg']);
for i=1:N
    imgr=imread(imgDir(i).name);
    gray=rgb2gray(imgr);
    recu(:,:,i)=gray(:,:);
end

[m,n]=size(gray);
    
Ex=zeros([m,n,N]);
Ey=zeros([m,n,N]);
Et=zeros([m,n,N]);

E=recu;
for k=1:N-1
    for i=1:m-1
        for j=1:n-1
            Ex(i,j,k)=1/4*(E(i,j+1,k)-E(i,j,k)+E(i+1,j+1,k)-E(i+1,j,k)+E(i,j+1,k+1)-E(i,j,k+1)+E(i+1,j+1,k+1)-E(i+1,j,k+1));
            Ey(i,j,k)=1/4*(E(i+1,j,k)-E(i,j,k)+E(i+1,j+1,k)-E(i,j+1,k)+E(i+1,j,k+1)-E(i,j,k+1)+E(i+1,j+1,k+1)-E(i,j+1,k+1));
            Et(i,j,k)=1/4*(E(i,j,k+1)-E(i,j,k)+E(i+1,j,k+1)-E(i+1,j,k)+E(i,j+1,k+1)-E(i,j+1,k)+E(i+1,j+1,k+1)-E(i+1,j+1,k));
        end
    end
end
%%
a=100*ones([m,n]);

for k=1:N
U=zeros([m,n]);
V=zeros([m,n]);
Um=zeros([m,n]);
Vm=zeros([m,n]);
    for i=2:m-1
        for j=2:n-1
            Um(i,j)=(1/6)*(U(i-1,j)+U(i,j+1)+U(i+1,j)+U(i,j-1))+(1/12)*(U(i-1,j-1)+U(i-1,j+1)+U(i+1,j+1)+U(i+1,j-1));
            Vm(i,j)=(1/6)*(V(i-1,j)+V(i,j+1)+V(i+1,j)+V(i,j-1))+(1/12)*(V(i-1,j-1)+V(i-1,j+1)+V(i+1,j+1)+V(i+1,j-1));
        end
    end
    
    U=U-Ex(:,:,k).*((Ex(:,:,k).*Um+Ey(:,:,k).*Vm+Et(:,:,k))./(Ex(:,:,k).^2+Ey(:,:,k).^2+a));
    V=V-Ey(:,:,k).*((Ex(:,:,k).*Um+Ey(:,:,k).*Vm+Et(:,:,k))./(Ex(:,:,k).^2+Ey(:,:,k).^2+a));
    imgs=flowToColor(U,V);
figure(1) 
     subplot(221)
     imshow(Ex(:,:,k),[])
     subplot(222)
     imshow(Ey(:,:,k),[])
     subplot(223)
     imshow(Et(:,:,k),[])
     subplot(224)
     imshow(imgs);
end

