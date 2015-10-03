function [e]=ReturnEdges(e,s)
a=[e(1,1) e(1,2)];
k=1;
if s==4
    for i=2:8
        if sqrt((e(1,1)-e(i,1))^2+(e(1,2)-e(i,2))^2)>20
            if k==1
                b=[e(i,1) e(i,2)];k=k+1;
            end
            if k==2
                if sqrt((b(1)-e(i,1))^2+(b(2)-e(i,2))^2)>20
                    c=[e(i,1) e(i,2)];k=k+1;
                end
            end
            if k==3
                if sqrt((b(1)-e(i,1))^2+(b(2)-e(i,2))^2)>20&&sqrt((c(1)-e(i,1))^2+(c(2)-e(i,2))^2)>20
                    d=[e(i,1) e(i,2)];k=k+1;
                end
            end
        end
    end
if k==1||k==2||k==3
    
return   
end
a,b,c,d
e(2,1)=a(1);e(2,2)=a(2);
e(4,1)=b(1);e(4,2)=b(2);
e(6,1)=c(1);e(6,2)=c(2);
e(8,1)=d(1);e(8,2)=d(2);
end

if s==3
    for i=2:8
        if sqrt((e(1,1)-e(i,1))^2+(e(1,2)-e(i,2))^2)>20
            if k==1
                b=[e(i,1) e(i,2)];k=k+1;
            end
            if k==2
                if sqrt((b(1)-e(i,1))^2+(b(2)-e(i,2))^2)>20
                    c=[e(i,1) e(i,2)];k=k+1;
                end
            end
        end
    end
if k==1||k==2
    
return   
end
e(2,1)=a(1);e(2,2)=a(2);
e(4,1)=b(1);e(4,2)=b(2);
e(8,1)=c(1);e(8,2)=c(2);
end

end