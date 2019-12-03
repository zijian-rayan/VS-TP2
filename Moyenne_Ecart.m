clc;
clear;
close all;

%% Moyenne et ¨¦cart type


    T=5;
    imgDir  = dir(['*.jpg']);
for iterat=1:600
    for i=iterat:iterat+T
        img=imread(imgDir(i).name);
        gray=rgb2gray(img);
        recu(:,:,i)=gray(:,:);
    end

    [m,n]=size(gray);
    
    for i=1:m
        for j=1:n
            moyenne(i,j) = mean(recu(i,j,:));
            a=recu(i,j,:);
            ecart(i,j)=std(double(a));
        end
    end
        figure(1)
        subplot(221)
        imagesc(recu(:,:,iterat+T))
        colorbar()
        subplot(222)
        imagesc(moyenne)
        colormap(bone)
        colorbar()
        subplot(223)
        imagesc(ecart)
        colormap(bone)
        colorbar()
end