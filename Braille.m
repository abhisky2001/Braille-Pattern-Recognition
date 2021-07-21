%DSP Mini Project
clc; close all; clear;

% Image Input
img = imread('img.jpg');

%Binarize Image 
img_gray = rgb2gray(img);
img_bw = imbinarize(img_gray,'adaptive','ForegroundPolarity','dark','Sensitivity',0.56);

%Inverting Binary Image
img_bw = ~img_bw;

%Dot Detection and Isolation
[centers, radii] = imfindcircles(img_bw,[1 6],'Sensitivity',0.95,'Method','twostage');

%Predeclaring larger blank image
[r,c,d] = size(img);
img_circ = zeros(r+20,c+20,d);

%Identifying Position of Dots in Image
for i=1:length(radii)
    theta=0:1:360;
    r=round(centers(i,1));
    c=round(centers(i,2));
    for j=1:length(r)
          img_circ(c(1,j),r(j),:)=[255 255 255];
    end
end

%Replacement Dot Image for Peaks 
radius = 2;
circ_mask = double(getnhood(strel('ball',radius,radius,0)));
img_pre = imfilter(img_circ,circ_mask,'same');
imgpre_gray = rgb2gray(img_pre);
imgpre_bw = imbinarize(imgpre_gray,'adaptive','ForegroundPolarity','dark','Sensitivity',0.58);
img_proc = imgpre_bw(any(imgpre_bw,2),any(imgpre_bw,1),:);
row = sum(img_proc');
col = sum(img_proc);
row_peak = findpeaks(row);
col_peak = findpeaks(col);
col_sz = size(col_peak,2);
row_sz = size(row_peak,2);

%Replacement Dot Image 
radius = 6;
circ_mask = double(getnhood(strel('ball',radius,radius,0)));

%Convolution
img_pre = imfilter(img_circ,circ_mask,'same');

%Binarize Pre Processed Image
imgpre_gray = rgb2gray(img_pre);
imgpre_bw = imbinarize(imgpre_gray,'adaptive','ForegroundPolarity','dark','Sensitivity',0.58);

%Resize Image to remove spaces
img_proc = imgpre_bw(any(imgpre_bw,2),any(imgpre_bw,1),:);

%Final Image for Pattern Recognition
img_final = imresize(img_proc, [row_sz, col_sz],'nearest');

%Split Image into Braille Grids 3x2
recog = splitImageIntoBlocks(img_final,3,2); %Custom Function
recog = recog';

%Loading Database
[key, data] = xlsread('letters.csv');
[key1] = xlsread('num.csv');
data1 = key1(:,1);
key1 = key1(:,2);

%Braille Recognition
for i = 1:size(recog,1)*size(recog,2)
    temp = cell2mat(recog(i));
    temp = uint16(reshape(temp,1,[]));
    validateattributes(temp, {'numeric'}, {'integer', 'nonnegative', '<', 10});
    temp = polyval(temp, 10);
    for j = 1:size(key)
        if(temp == key(j))
            disp(data(j));
            if(temp == 1111)
                temp = cell2mat(recog(i+1));
                temp = uint16(reshape(temp,1,[]));
                validateattributes(temp, {'numeric'}, {'integer', 'nonnegative', '<', 10});
                temp = polyval(temp, 10);
                for k = 1:size(key1)
                    if(temp == key1(k))
                        disp(data1(k));
                    end
                end
            end
            i = i+2;
        end
    end
end