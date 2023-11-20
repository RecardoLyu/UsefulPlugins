%% Replace the transparent background of the picture with a white one

%%配置
Path ='.\';          % 原图路径
File = dir(fullfile(Path,'*.png'));  % 获取所有.png图片
save_path='.\after\';     % 保存路径
%纯色背景RGB参数
Red=0XF2;
Green=0XFD;
Blue=0XFF;
%%处理 
FileNames = {File.name}';     
[file_num,~] = size(FileNames);
for num=1:file_num
    [Yuantu, map, alpha] = imread(strcat(Path ,FileNames{num})); %读取待处理图片
    [m,n] = size(alpha);
    %纯色背景
    I=zeros(m,n,3);
    I=uint8(I);
    R=I(:,:,1);
    G=I(:,:,2);
    B=I(:,:,3);
    R(:,:)=Red;
    G(:,:)=Green;
    B(:,:)=Blue;
    rgb=cat(3,R,G,B);   %构建矩阵
    %合成
    result_tu = rgb;  
    for i= 1:m
        for j = 1:n
            k = double(alpha(i,j))/double(255);
            result_tu(i,j,:) = k*Yuantu(i,j,:) +  (1-k)*rgb(i,j,:); 
        end
    end
imwrite(result_tu,strcat(save_path,FileNames{num}));
sprintf(' %d/%d.',num,file_num)%显示进度(当前图片数/全部图片数)
end
