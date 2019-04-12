function object_data_list = CS6640_extract_features(videos)
object_data_list=[];
for vidNo=1:length(videos)
    vidObj=videos(vidNo);
    %% CS6640_MM - A4 - Segments moving objects in video
    M = CS6640_MM(vidObj);
    %% CS6640_object_data - A4 - extracts object data from a video
    nFrames=vidObj.NumberOfFrames;
    object_data=zeros(nFrames,3);
    for k=1:nFrames
        frame=read(vidObj,k);
        regions=bwlabel(M(k).cdata(:,:,:));
        s=regionprops(regions,'centroid','area','pixellist',...
            'extent','perimeter','majoraxislength','minoraxislength'); 
        regarea=[s.Area];
        [x,p]=max(regarea);
        if ~isempty(p)
            if(s(p).Area==1)
                continue;
            else
                temp_min=min(s(p).PixelList);
                temp_max=max(s(p).PixelList);
            end
            %object_data(k,1)=temp_max(2)-temp_min(2); %Length
            %object_data(k,2)=temp_max(1)-temp_min(1); %Width
            object_data(k,1)=size(s(p).PixelList,1);  %Number of Pixels
            %object_data(k,2)=s(p).Extent;  %Extent
            %object_data(k,3)=s(p).Perimeter; %Perimeter
            object_data(k,2)=s(p).MajorAxisLength; %MajorAxisLength
            object_data(k,3)=s(p).MinorAxisLength; %MinorAxisLength            
            %object_data(k,1)=x; %Area
            %obj_crop=frame(temp_min(2):temp_max(2)...
            %    ,temp_min(1):temp_max(1),:); 
            %object_data(k,8)=median(median(obj_crop(:,:,1)));
            %object_data(k,9)=median(median(obj_crop(:,:,2)));
            %object_data(k,10)=median(median(obj_crop(:,:,3)));
            %object_data(k,11)=median(median(rgb2gray(obj_crop)));            
        end
    end
object_data_list=[object_data_list; object_data];   
end
%%
%video1=VideoReader('C:\Users\Rohit Singh\OneDrive\MSCS\CS6640 Image
%Processing\Assignments\A7\Videos\bus1.avi');

%video2=VideoReader('C:\Users\Rohit Singh\OneDrive\MSCS\CS6640 Image
%Processing\Assignments\A7\Videos\bus2.avi');

%video3=VideoReader('C:\Users\Rohit Singh\OneDrive\MSCS\CS6640 Image
%Processing\Assignments\A7\Videos\car1.avi');

%video4=VideoReader('C:\Users\Rohit Singh\OneDrive\MSCS\CS6640 Image
%Processing\Assignments\A7\Videos\car2.avi');

%video5=VideoReader('C:\Users\Rohit Singh\OneDrive\MSCS\CS6640 Image
%Processing\Assignments\A7\Videos\truck1.avi');

%video6=VideoReader('C:\Users\Rohit Singh\OneDrive\MSCS\CS6640 Image
%Processing\Assignments\A7\Videos\truck2.avi');

%video7=VideoReader('C:\Users\Rohit Singh\OneDrive\MSCS\CS6640 Image
%Processing\Assignments\A7\Videos\bus3.avi');

%video8=VideoReader('C:\Users\Rohit Singh\OneDrive\MSCS\CS6640 Image
%Processing\Assignments\A7\Videos\car3.avi');

%video9=VideoReader('C:\Users\Rohit Singh\OneDrive\MSCS\CS6640 Image
%Processing\Assignments\A7\Videos\truck3.avi');