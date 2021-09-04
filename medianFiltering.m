clc
clear
close all
% Soru3
mkdir('frames')
v = VideoReader('video.mp4');
i = 1;
while hasFrame(v)
    frame = readFrame(v);
    [row,colum,cl]=size(frame);
    input=zeros(row+2,colum+2);
    for rgb=1:3
        for r=2:row+1
                for c=2:colum+1
                    input(r,c,rgb)=frame(r-1,c-1,rgb);
                end
        end
    end
    for rgb =1:3
        for r=2:row+1
                for c=2:colum+1
                    M=[input(r-1,c-1,rgb),input(r-1,c,rgb),input(r-1,c+1,rgb);
                       input(r,c-1,rgb),input(r,c,rgb),input(r,c+1,rgb);
                       input(r+1,c-1,rgb),input(r+1,c,rgb),input(r+1,c+1,rgb)];

                    S= sort(M(:));
                    output(r-1,c-1,rgb)=S(5,1);
                end
        end
    end   
   output = uint8(output);
   % https://www.mathworks.com/help/matlab/import_export/convert-between-image-sequences-and-video.html
   frame_file = [sprintf('%03d',i) '.jpg'];
   frames_dict = fullfile('frames',frame_file);
   imwrite(output,frames_dict)    
   i = i+1;  
end
frameNames = dir(fullfile('frames','*.jpg'));
frameNames = {frameNames.name}';

outputVideo = VideoWriter('video_out.mp4','MPEG-4');
outputVideo.FrameRate = v.FrameRate;
open(outputVideo);
for i = 1:length(frameNames)
   img = imread(fullfile('frames',frameNames{i}));
   writeVideo(outputVideo,img)
end
close(outputVideo);