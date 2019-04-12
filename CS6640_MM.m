function M = CS6640_MM(vidObj)
% CS6640_MM - segments moving objects in video
% On input:
%        vidObj (video object obtained by VideoReader): input video
% On output:
%       M (Matlab movie): movie of segmented moving objects
% Call:
%       vidObj = VideoReader(’../../../video.avi’);
%       M = CS6640_MM(vidObj);
% Author:
%       Rohit Singh
%       Fall 2018
%       UU
%

%background and frame extraction from video
video=vidObj;
nFrames=video.NumberOfFrames;
frames=rgb2gray(read(video,1));
bImage= zeros(size(frames));
for i = 1:nFrames;
    frames(:,:,i)=rgb2gray(read(video,i));    
    bImage = bImage + double(frames(:,:,i));
end;
bImageMean = mat2gray(bImage/nFrames);
diffFrames=zeros(size(frames));

%grayscale difference images
for i = 1:nFrames;
    diffFrames(:,:,i)=abs(abs(mat2gray(frames(:,:,i))-bImageMean).^0.8);    
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%To remove stationary patches from segmented images
%{
bImage= zeros(size(diffFrames(:,:,1)));
for i = 1:nFrames;    
    bImage = bImage + diffFrames(:,:,1);
end;
bImageMean = bImage/nFrames;
for i = 1:nFrames;
    diffFrames(:,:,i)=diffFrames(:,:,i)-bImageMean;    
end;
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%grayscale movie
%{
for i=1:nFrames
  imshow(diffFrames(:,:,i));
  movGray(i) = getframe(gca);
end;
%}

%convertimg to bw with custom threshold
thresh=[];
for i=1:nFrames;
    thresh=[thresh graythresh(diffFrames(:,:,i))];
end;
threshmax=max(thresh);
threshmin=min(thresh);

for i=1:nFrames;       
    diffFramesBW(:,:,i)=im2bw(diffFrames(:,:,i),2*threshmax/3); 
%     f=fspecial('average',3);
%     diffFramesBW(:,:,i)=imfilter(diffFramesBW(:,:,i),f);    
    
%     diffFramesBW(:,:,i)=bwmorph(diffFramesBW(:,:,i),'clean');
    
%     diffFramesBW(:,:,i)=bwmorph(diffFramesBW(:,:,i),'bridge',20);

%     diffFramesBW(:,:,i)=bwmorph(diffFramesBW(:,:,i),'close');

%     diffFramesBW(:,:,i)=bwmorph(diffFramesBW(:,:,i),'dilate',5);
%     diffFramesBW(:,:,i)=bwmorph(diffFramesBW(:,:,i),'fill');
%     diffFramesBW(:,:,i)=bwmorph(diffFramesBW(:,:,i),'spur');
%     diffFramesBW(:,:,i)=bwmorph(diffFramesBW(:,:,i),'erode',3);     

%     diffFramesBW(:,:,i)=bwmorph(diffFramesBW(:,:,i),'dilate',3);
%     diffFramesBW(:,:,i)=bwmorph(diffFramesBW(:,:,i),'majority');
%     diffFramesBW(:,:,i)=bwmorph(diffFramesBW(:,:,i),'erode',3);      
%     diffFramesBW(:,:,i)=bwmorph(diffFramesBW(:,:,i),'spur');

%     diffFramesBW(:,:,i)=bwmorph(diffFramesBW(:,:,i),'dilate',2);
%     diffFramesBW(:,:,i)=bwmorph(diffFramesBW(:,:,i),'spur');   
      
%    diffFramesBW(:,:,i)=bwmorph(diffFramesBW(:,:,i),'skel',Inf);

%    diffFramesBW(:,:,i)=bwmorph(diffFramesBW(:,:,i),'dilate',5);
%    diffFramesBW(:,:,i)=bwmorph(diffFramesBW(:,:,i),'erode',3);
%{
    dl=ones(25,25);
    er=ones(25,25);
     diffFramesBW(:,:,i)=imdilate(diffFramesBW(:,:,i),dl);
     %diffFramesBW(:,:,i)=bwmorph(diffFramesBW(:,:,i),'fill');    
     diffFramesBW(:,:,i)=imerode(diffFramesBW(:,:,i),er);
     
     diffFramesBW(:,:,i)=imfilter(diffFramesBW(:,:,i),f);     
%}
%interval = [0 0 0
%            1 -1 1 
%            0 0 0]
%   diffFramesBW(:,:,i)=bwhitmiss(diffFramesBW(:,:,i),interval);
end;
for i=1:nFrames 
  I=255*diffFramesBW(:,:,i);
  map=colormap(gray(256));
  movBW(i) = im2frame(uint8(I),map);
end;
M=movBW;

%vidObj=VideoReader('C:\Users\Rohit Singh\OneDrive\MSCS\CS6640 Image
%Processing\Assignments\A4\Videos\video1.avi');

%vidObj=VideoReader('C:\Users\Rohit Singh\OneDrive\MSCS\CS6640 Image
%Processing\Assignments\A4\Videos\video2.avi');

%vidObj=VideoReader('C:\Users\Rohit Singh\OneDrive\MSCS\CS6640 Image
%Processing\Assignments\A4\Videos\video1.avi');