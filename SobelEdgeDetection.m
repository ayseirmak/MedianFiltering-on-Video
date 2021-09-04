clc
clear
close all

mkdir('frames')
v = VideoReader('video.mp4');
i = 1;
Gx = [-1 0 1; -2 0 2; -1 0 1];
Gy = [1 2 1; 0 0 0; -1 -2 -1];

while hasFrame(v)
    frame = readFrame(v);
%     frame=rgb2gray(frame);
    [row,colum]=size(frame);
    input=zeros(row+2,colum+2);
    p=fix(length(Gx)/2);
    for r=p+1:row+p
        for c=p+1:colum+p
            input(r,c)=frame(r-p,c-p);
        end
    end
   for r=p+1:row+p
        for c=p+1:colum+p   
            gx=sum(dot(input(r-p:r+p,c-p:c+p),Gx,2));
            gy=sum(dot(input(r-p:r+p,c-p:c+p),Gy,2));
            output(r-p,c-p)=abs(gx)+abs(gy);
        end
    end
   output = uint8(output);
   for r=1:row
    for c=1:colum
        if(output(r,c)>128)
            tresh_out(r,c)=1;
        else
            tresh_out(r,c)=0;
        end
    end
   end

   % https://www.mathworks.com/help/matlab/import_export/convert-between-image-sequences-and-video.html
   frame_file = [sprintf('%03d',i) '.jpg'];
   frames_dict = fullfile('frames',frame_file);
   imwrite(output,frames_dict)    
   i = i+1;  
end

close(outputVideo);