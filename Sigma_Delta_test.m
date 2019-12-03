clc;
clear;
close all;

    %% sigma delta
    T=600;
    imgDir  = dir(['*.jpg']);
    for i=1:T
        img=imread(imgDir(i).name);
        gray=rgb2gray(img);
        recu(:,:,i)=gray(:,:);
    end
    [m,n]=size(gray);
    M=zeros(m,n,T);
    V=zeros(m,n,T);
    est=zeros(m,n,T);
    N=4;
    for t=2:T
        for i=1:m
            for j=1:n
                if(M(i,j,t-1)<recu(i,j,t))
                    M(i,j,t)=M(i,j,t-1)+1;
                elseif(M(i,j,t-1)>recu(i,j,t))
                    M(i,j,t)=M(i,j,t-1)-1;
                else
                     M(i,j,t)=M(i,j,t-1);
                end
            end
        end
    end
    
    
    for t=1:T
        O(:,:,t)=abs(M(:,:,t)-double(recu(:,:,t)));
    end
    for t=2:T
        for i=1:m
            for j=1:n
                if(V(i,j,t-1)<N*O(i,j,t))
                    V(i,j,t)=V(i,j,t-1)+1;
                elseif(V(i,j,t-1)>N*O(i,j,t))
                    V(i,j,t)=V(i,j,t-1)-1;
                else
                    V(i,j,t)=V(i,j,t-1);
                end
                 V(i,j,t)=max(min(V(i,j,t),60),40);
            end
        end
        
    end
    for t=2:T
        for i=1:m
            for j=1:n
                if(O(i,j,t)<V(i,j,t))
                    est(i,j,t)=0;
                else
                    est(i,j,t)=1;
                end
            end
        end
    end
    
 for i=1:T
    imagesc(est(:,:,i))
    colormap(bone)
    colorbar
    pause(0.01);
 end

%% fin
























