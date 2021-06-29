B=imread('square_1.bmp');
% A = rgb2gray(photo);
% grey = rgb2gray(photo);
threshold =0.4;

% grey = double(grey)/255;

% B = grey <= threshold;

se = strel('disk',5);
E = imerode(B,se);

contour = (B-E);

bwferet_function = bwferet(imrotate(contour, 30));
%% Feret box and its horizontal and vertical diameter 

countour_rotation = imrotate(contour, 0);


x_max = 0;
x_min = size(countour_rotation,1);

y_max = 0;
y_min = size(countour_rotation,2);



for row = 1:size(countour_rotation,1)
    for col = 1:size(countour_rotation,2)
        if(countour_rotation(row,col) == 1)
            if(row > y_max)
                y_max = row;
                
            end
            if(row < y_min)
                y_min = row;
                
            end
            if(col > x_max)
                x_max = col;
                
            end
            if(col < x_min)
                x_min = col;
                
            end
        end
    end
end

line = countour_rotation;

%gorizonatl and vertical of feret box
out = [x_max-x_min, y_max-y_min];

line(y_min, x_min:x_max) = 1;
line(y_max, x_min:x_max) = 1;
line(y_min:y_max, x_min) = 1;
line(y_min:y_max, x_max) = 1;

% imshow(line);



%% Diagonal of Feret box

diagonal = sqrt((x_max-x_min)^2+(y_max-y_min)^2);

%% Diagonal of oriented box

alfa_max = 360;
delta = 1;

vector = 0:delta:alfa_max;
degree = size(vector,2);
mindiag = 1000000;

countour_rotation1 = imrotate(contour, 0);


x_max1 = 0;
x_min1 = size(countour_rotation1,1);

y_max1 = 0;
y_min1 = size(countour_rotation1,2);


for i = 1:degree
    
    countour_rotation1 = imrotate(contour, i);


    x_max1 = 0;
    x_min1 = size(countour_rotation1,1);

    y_max1 = 0;
    y_min1 = size(countour_rotation1,2);

    
    for row = 1:size(countour_rotation1,1)
        for col = 1:size(countour_rotation1,2)
            if(countour_rotation1(row,col) == 1)
                if(row > y_max1)
                    y_max1 = row;

                end
                if(row < y_min1)
                    y_min1 = row;

                end
                if(col > x_max1)
                    x_max1 = col;

                end
                if(col < x_min1)
                    x_min1 = col;

                end
            end
        end
    end
    
    diag1 = sqrt((x_max1-x_min1)^2+(y_max1-y_min1)^2);
    
    if(mindiag > diag1)
        mindiag = diag1;
    end
    
end


%% Object diameter

ObjectDiameter = objectDiameter(contour);



%% morphological thickness

C = B;
count2 = 0;
while sum(C(:))>1
    C = imerode(C, se);
    count2 = count2 + 1;
end
%% Object diameter

function maximalDiameter = objectDiameter(image)
X_max = 0;
X_min = size(image,1);

Y_max = 0;
Y_min = size(image,2);
vector = [];  %storing in two element vector position of pixel image
maximalDiameter = 0;

for row = 1:size(image,1)
    for col = 1:size(image,2)
        if(image(row,col) == 1)
            vector = [vector [row,col]'];
        end
    end
end


for row = 1:size(vector,2)
    for col = 1:size(vector,2)
        diam = sqrt((vector(1,row) - vector(1,col))^2 + (vector(2,row) - vector(2,col))^2);
        if diam > maximalDiameter
            maximalDiameter = diam;
            X_max = vector(1,row);
            X_min = vector(1,col);
            Y_max = vector(2,row);
            Y_min = vector(2,col);
        end
    end

end
end


