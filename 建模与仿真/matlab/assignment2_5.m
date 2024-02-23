x1=-3:0.1:3;
x2=-3:0.1:3;
for i=1:length(x2)
        for j=1:length(x1)
            if(x1(j)+x2(j)>1)
             z(i,j)=0.5457*exp(-0.75*x2(i)^2-3.75*x1(j)^2-1.5*x1(j));
          else if -1<x1(j)+x2(j)<=1
               z(i,j)=0.5457*exp(-0.75*x2(i)^2-3.75*x1(j)^2-1.5*x1(j));
               else if x1(j)+x2(j)<=-1
                       z(i,j)=0.5457*exp(-0.75*x2(i)-3.75*x1(j)+1.5*x1(j));
                   end
                end
            end
        end
end
axis([-2,2,-2,2,min(min(z)),max(max(z))]);
surf(x1,x2,z);
