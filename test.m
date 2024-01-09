disp ('run test');
delete testFile.mat;
a=10;b=20;
c=a+b;
d=now;
save('testFile.mat','a','b','c')
