% Inclass11
%GB comments
1) 100
2) 100
3) 100
4) 100
overall: 100

% You can find a multilayered .tif file with some data on stem cells here:
% https://www.dropbox.com/s/83vjkkj3np4ehu3/011917-wntDose-esi017-RI_f0016.tif?dl=0

% 1. Find out (without reading  the entire file) -  (a) the size of the image in
% x and y, (b) the number of z-slices, (c) the number of time points, and (d) the number of
% channels.

% (a). 
file1 = '011917-wntDose-esi017-RI_f0016.tif';
reader = bfGetReader(file1);
[reader.getSizeX, reader.getSizeY]
ans =

        1024        1024
% (b).
reader.getSizeZ
ans =

     1
% (c). 
reader.getSizeT
ans =

    68
% (d). 
reader.getSizeC
ans =

     2

% 2. Write code which reads in all the channels from the 30th time point
% and displays them as a multicolor image.

time = 30;
zplane = 1;
chan1 = 1;
chan2 = 2;

iplane1 = reader.getIndex(zplane-1, chan1-1, time-1) + 1;
iplane2 = reader.getIndex(zplane-1, chan2-1, time-1) + 1;

img1 = bfGetPlane(reader, iplane1);
imshow(img1, [500 5000]);

img2 = bfGetPlane(reader, iplane2);
imshow(img2, [500 1500]);

img2show = cat(3, imadjust(img1), imadjust(img2), zeros(size(img1)));
imshow(img2show);

% 3. Use the images from part (2). In one of the channels, the membrane is
% prominently marked. Determine the best threshold and make a binary
% mask which marks the membranes and displays this mask. 

threshold = 890;
img_bw = img1 > threshold;
imshow(img_bw);

% 4. Run and display both an erosion and a dilation on your mask from part
% (3) with a structuring element which is a disk of radius 3. Explain the
% results.

imshow(imerode(img_bw, strel('disk', 3)));
imshow(imdilate(img_bw, strel('disk', 3)));

% The imerode function takes away most of the pixels such that the membrane
% is mostly gone and not effectively visible. The imdilate function
% exaggerates the appearance of the membrane (makes the linings of the
% membrane appear thicker). The threshold used in part 3. is therefore
% probably best suited to represent the membrane, as compared to the
% imerode and imdilate functions. 
