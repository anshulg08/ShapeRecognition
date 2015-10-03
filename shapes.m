function [s]=shapes(im)

im=imread('g.png');
im(:,:,1)=medfilt2(im(:,:,1),[11 11],'symmetric');
im(:,:,2)=medfilt2(im(:,:,2),[11 11],'symmetric');
im(:,:,3)=medfilt2(im(:,:,3),[11 11],'symmetric');    
im=im2bw(im);
im=~im;
im=bwlabel(im);
imshow(im)
s=regionprops(im,'Area','Perimeter','Eccentricity','MajoraxisLength','MinorAxisLength','PixelList','EquivDiameter','Extrema','Centroid');
n=size(s,1);
for i=1:n
    if s(i,1).Area<100
        continue
    end
    a=s(i,1).Area;p=s(i,1).Perimeter;e=s(i,1).Eccentricity;l1=s(i,1).MajorAxisLength;l2=s(i,1).MinorAxisLength;ed=s(i,1).EquivDiameter;c=s(i,1).Centroid;
    
    if (e<0.2)&&(abs(a-(3.14*l1*l2/4))<20)&&(abs(l1-l2)<10)&&(abs(l1-ed)<10)&&(a~=1) %Circle dtection
        'circle detected'
        text(c(1),c(2),'Circle');
        continue
    end
    if (e<0.3)&&(abs(l1-l2)<10)&&(abs(4*sqrt(a)-p)<35&&(abs(a-(3.14*l1*l2/4))>20))    %square detection
        'square detected'
         text(c(1),c(2),'Square');
         continue
    end
    if  (e>0.1&&e<.9)&&(abs(a-(3.14*l1*l2/4))<20)            %ellipse detction
        'ellipse detected'
        text(c(1),c(2),'Ellipse');
        continue
    end
    if (e>.8)&&(l2<5)         %line detection
        'line detected'
        text(c(1),c(2),'Line');
        continue
    end
    co=ReturnEdges(s(i,1).Extrema,3);
    cx=(co(2,1)+co(4,1)+co(8,1))/3;cy=(co(2,2)+co(4,2)+co(8,2))/3;
    if  sqrt((cx-c(1))^2+(cy-c(2))^2)<6&&(abs(a-(3.14*l1*l2/4))>20)%triangle detection
        'triagle detected'
        text(c(1),c(2),'Triangle');
        continue
    end
    co=ReturnEdges(s(i,1).Extrema,4);
    c1x=(co(2,1)+co(6,1))/2;c1y=(co(2,2)+co(6,2))/2;
    c2x=(co(4,1)+co(8,1))/2;c2y=(co(4,2)+co(8,2))/2;
    m1=(co(4,2)-co(2,2))/(co(4,1)-co(2,1));
    m2=(co(8,2)-co(2,2))/(co(8,1)-co(2,1));
    m=(m2-m1)/(1+m1*m2);
    if isinf(m)==1||isnan(m)==1
        if isinf(m1)
            theta=180*atan(-1/m2)/pi;
        end
        if isinf(m2)
            theta=180*atan(1/m1)/pi;
        end
        if isinf(m1)==0&&isinf(m2)==0
            theta=90;
        end
    else
        theta=180*atan(m)/pi;
    end
    theta=abs(theta);
       
    if (sqrt((c1x-c2x)^2+(c1y-c2y)^2)<5)&&(theta>=97||theta<=83)&&(abs(a-(3.14*l1*l2/4))>30)&&(l2>5)%parallelogram detection
        'parallelogram detected'
        text(c(1),c(2),'Parallelogram');
        continue
    end
    e;
    sqrt((c1x-c2x)^2+(c1y-c2y)^2)
    theta;
    abs(l1-l2)
    l2
    if (e>0.2)&&(sqrt((c1x-c2x)^2+(c1y-c2y)^2)<5)&&(theta<97&&theta>83)&&(abs(l1-l2)>5)&&(l2>5)%rectangle detection
        'rectangle detected'
        text(c(1),c(2),'Rectangle');
        continue
    end
   

end
end
