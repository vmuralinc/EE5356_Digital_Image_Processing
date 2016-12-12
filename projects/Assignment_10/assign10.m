fid = fopen('akiyo30_qcif_300.yuv','r');
h=[-7 -11 4 35 67 80 67 35 4 -11 -7];
wd = 176;
ht = 144;
elements = wd * ht; 
 
%Progressive to interlaced
for i=1:2     
     [x,cnt] = fread(fid,elements,'uchar');
     x = reshape(x,[wd,ht])';
     y(:,:,i)=x;
     [x,cnt] = fread(fid,elements/4,'uchar');
     x = reshape(x,[wd/2,ht/2])';
     [x,cnt] = fread(fid,elements/4,'uchar');
     x = reshape(x,[wd/2,ht/2])';
end
 
y_intr_fld1=y(1:2:ht,:,1);
y_intr_fld2=y(2:2:ht,:,2);
 
figure,imagesc(y(:,:,1));title('Original Frame 1');
figure,imagesc(y(:,:,2));title('Original Frame 2');
figure,imagesc(y_intr_fld1);title('Interlaced Field 1');
figure,imagesc(y_intr_fld2);title('Interlaced Field 2');
 

a=1/4;
%Interlaced to Progressive Frame 1
y_prog_frame1(1:2:ht,:)=y_intr_fld1(:,:);
y_prog_frame1(2,:)=y_intr_fld2(1,:);
y_prog_frame1(ht,:)=y_intr_fld2(ht/2,:);
 
for i=4:2:ht-2
    y_prog_frame1(i,:)=0.5*( y_prog_frame1(i-1,:) + y_prog_frame1(i+1,:) + 2*a.*y_intr_fld2(i/2,:) - a*y_intr_fld2((i/2)+1,:) - a*y_intr_fld2((i/2)-1,:));
end
 
%Interlaced to Progressive Frame 2
y_prog_frame2(2:2:ht,:)=y_intr_fld1(:,:);
y_prog_frame2(1,:)=y_intr_fld1(1,:);
y_prog_frame2(ht,:)=y_intr_fld1(ht/2,:);
for i=3:2:ht-3
    y_prog_frame2(i,:)=0.5*(  y_prog_frame2(i-1,:) +  y_prog_frame2(i+1,:) + 2*a.*y_intr_fld1((i+1)/2,:) - a*y_intr_fld1((i+3)/2,:) - a*y_intr_fld1((i-1)/2,:));
end
figure,imagesc(y_prog_frame1);title('Progressive Frame 1');
figure,imagesc(y_prog_frame2);title('Progressive Frame 2');