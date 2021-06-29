a = 16;

Area_real = a^2;
Permiter_real = 4*a;

background = a + 100;
image = zeros(background);

start = (background-a)/2;
finish = start-1 + a;
image(start:finish,start:finish) = 1;


Area_numericaly = area(image);

se = strel('disk',1);
E = imerode(image,se);

contour = (image-E);


Permiter_numericaly = perimeter(contour);


% rotation

alfa_max = 360;
delta = 2;

vector = 0:delta:alfa_max;
amount = size(vector,2);

vector1 = zeros(1,amount);
vector2 = zeros(1,amount);

for i=1:amount
    degree = vector(i);
    image_rotation = imrotate(image, degree);
    contour_rotation = image_rotation - imerode(image_rotation, se);
    contour_bwperim = bwperim(image_rotation);
    
    vector1(i) = sum(image_rotation(:));
    vector2(i) = sum(contour_rotation(:));
    
    vector3(i) = bwarea(image_rotation(:));
    vector4(i) = sum(contour_bwperim(:));
    
end

figure;
subplot(2,2,1);
plot(vector,vector1);
ylabel('Area');

subplot(2,2,2);
plot(vector,vector2);
ylabel('Permiter');

subplot(2,2,3);
plot(vector,vector3);
ylabel('Area');
title('bwarea');

subplot(2,2,4);
plot(vector, vector4);
ylabel('Permiter');
title('bwperim');

%resize

% vector = 0:100;
% amount = size(vector,2);
% 
% for i = 1:amount
%     image_resize = imresize(image,i/(amount-1));
%     contour_resize = image_resize - imerode(image_resize, se);
%     contour_bwperim = bwperim(image_resize);
%     
%     vector5(i) = sum(image_resize(:));
%     vector6(i) = sum(contour_resize(:));
%     
%     vector7(i) = bwarea(image_resize(:));
%     vector8(i) = sum(contour_bwperim(:));
% end
% 
% figure;
% subplot(2,2,1);
% plot(vector, vector5);
% ylabel('Area');
% 
% 
% subplot(2,2,2);
% plot(vector, vector6);
% ylabel('Permiter');
% 
% subplot(2,2,3);
% plot(vector,vector7);
% ylabel('Area');
% title('bwarea');
% 
% subplot(2,2,4);
% plot(vector, vector8);
% ylabel('Permiter');
% title('bwperim');



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
