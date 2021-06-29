photo=imread('circle_1.bmp');

% A = rgb2gray(photo);
% grey = rgb2gray(photo);
% threshold =0.4;
% 
% grey = double(grey)/255;
% 
% B = grey <= threshold;


Area = area(photo);

se = strel('disk',1);
E = imerode(photo,se);

contour = (photo-E);
imshow(contour);

Perimeter = perimeter(contour);

circularity = Circularity(photo);
compactness = Perimeter^2/(4*pi*Area);

function Circular = Circularity(image)


% Centroid of object
props = regionprops(image, 'Centroid');
x = props.Centroid(1);
y = props.Centroid(2);

% Boundary
bounds = bwboundaries(image);
distance = NaN(size(bounds{1,1},1),1);


%distance between centroid of object and boundary
for i=1:size(bounds{1,1},1)
        distance(i) = sqrt((x-bounds{1,1}(i,2))^2 + (y-bounds{1,1}(i,1))^2);
end

avrOfDistance = mean(distance);
stdOfDistance = std(distance);

Circular = (sqrt(3)*stdOfDistance)/avrOfDistance;
end


function count2 = perimeter(image)
    count2 = 0;
    for row = 1:size(image,1)
        for col = 1:size(image,2)
            if(image(row,col)>0)
                count2 = count2 + 1;
            end
        end
    end
end

function count1 = area(image)
    count1 = 0;
    for row = 1:size(image,1)
        for col = 1:size(image,2)
            if(image(row,col)>0)
                count1 = count1 + 1;
            end
        end
    end
end

