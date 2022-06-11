%___________________________________________________________________%
%  Grey Wold Optimizer (GWO) source codes version 1.0               %
%                                                                   %
%  Developed in MATLAB R2011b(7.13)                                 %
%                                                                   %
%  Author and programmer: Seyedali Mirjalili                        %
%                                                                   %
%         e-Mail: ali.mirjalili@gmail.com                           %
%                 seyedali.mirjalili@griffithuni.edu.au             %
%                                                                   %
%       Homepage: http://www.alimirjalili.com                       %
%                                                                   %
%   Main paper: S. Mirjalili, S. M. Mirjalili, A. Lewis             %
%               Grey Wolf Optimizer, Advances in Engineering        %
%               Software , in press,                                %
%               DOI: 10.1016/j.advengsoft.2013.12.007               %
%                                                                   %
%___________________________________________________________________%

% You can simply define your cost in a seperate file and load its handle to fobj 
% The initial parameters that you need are:
%__________________________________________
% fobj = @YourCostFunction
% dim = number of your variables
% Max_iteration = maximum number of generations
% SearchAgents_no = number of search agents
% lb=[lb1,lb2,...,lbn] where lbn is the lower bound of variable n
% ub=[ub1,ub2,...,ubn] where ubn is the upper bound of variable n
% If all the variables have equal lower bound you can just
% define lb and ub as two single number numbers

% To run GWO: [Best_score,Best_pos,GWO_cg_curve]=GWO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj)
%__________________________________________

clear all 
clc
global windsize
windsize = 32;
SearchAgents_no = 100; % Number of search agents
Max_iteration = 100; % Maximum numbef of iterations

fobj = @fitness;
dim = 15;
lb = [0, 0, 0, 0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 0.1];
ub = [1, 1, 1, 1, 1, 1, 1, 1, -1, 10, 1, 1, 1, 1, 1];

[Best_score,Q,GWO_cg_curve] = GWO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
plot(GWO_cg_curve)
title('window size 32');

data1 = [5,11,16,23,36,58,29,20,10,8,3,0,0,2,11,27,47,63,60,39,28,26,22,11,21,40,78,122,103,73,47,35,11,5,16,34,70,81,111,101,73,40,20,16,5,11,22,40,60,80.9,83.4,47.7,47.8,30.7,12.2,9.6,10.2,32.4,47.6,54,62.9,85.9,61.2,45.1,36.4,20.9,11.4,37.8,69.8,106.1,100.8,81.6,66.5,34.8,30.6,7,19.8,92.5,154.4,125.9,84.8,68.1,38.5,22.8,10.2,24.1,82.9,132,130.9,118.1,89.9,66.6,60,46.9,41,21.3,16,6.4,4.1,6.8,14.5,34,45,43.1,47.5,42.2,28.1,10.1,8.1,2.5,0,1.4,5,12.2,13.9,35.4,45.8,41.1,30.1,23.9,15.6,6.6,4,1.8,8.5,16.6,36.3,49.6,64.2,67,70.9,47.8,27.5,8.5,13.2,56.9,121.5,138.3,103.2,85.7,64.6,36.7,24.2,10.7,15,40.1,61.5,98.5,124.7,96.3,66.6,64.5,54.1,39,20.6,6.7,4.3,22.7,54.8,93.8,95.8,77.2,59.1,44,47,30.5,16.3,7.3,37.6,74,139,111.2,101.6,66.2,44.7,17,11.3,12.4,3.4,6,32.3,54.3,59.7,63.7,63.5,52.2,25.4,13.1,6.8,6.3,7.1,35.6,73,85.1,78,64,41.8,26.2,26.7,12.1,9.5,2.7,5,24.4,42,63.5,53.8,62,48.5,43.9,18.6,5.7,3.6,1.4,9.6,47.4,57.1,103.9,80.6,63.6,37.6,26.1,14.2,5.8,16.7,44.3,63.9,69,77.8,64.9,35.7,21.2,11.1,5.7,8.7,36.1,79.7,114.4,109.6,88.8,67.8,47.5,30.6,16.3,9.6,33.2,92.6,151.6,136.3,134.7,83.9,69.4,31.5,13.9,4.4,38,141.7,190.2,184.8,159,112.3,53.9,37.5,27.9,10.2,15.1,47,93.8,105.9,105.5,104.5,66.6,68.9,38,34.5,15.5,12.6,27.5,92.5,155.4,154.7,140.5,115.9,66.6,45.9,17.9,13.4,29.2,100.2
];

min_data= min(data1);
max_data= max(data1);
data1 = ((data1-min_data)/(max_data-min_data))*2-1;
length = size(data1,2);  %test+train
length_test = 67; %test

for i = 1:length-windsize
    x_data(i,1:windsize)= data1(i:i+windsize-1);
    y_data(i,1)= data1(i+windsize);  
end

xpts = round(Q(1,1)) * Q(1,5) * real(kernel(x_data,3,Q(1,10),0));       %'poly'
xrts = round(Q(1,2)) * Q(1,6) * real(kernel(x_data,4,Q(1,11),0));       %'rbf'
xets = round(Q(1,3)) * Q(1,7) * real(kernel(x_data,5,Q(1,12),0));       %'erbf'
xsts = round(Q(1,4)) * Q(1,8) * real(kernel(x_data,6,Q(1,13),Q(1,14))); %'sigmoid'
xgts = Q(1,9) * kernel_g(x_data,'gaussian',Q(1,15));

xAllts = xpts + xrts + xets + xsts + xgts;

min_kenel = min(xAllts);
max_kernel = max(xAllts);

for j=1:size(xAllts,2)
    if   max_kernel(1,j)~= min_kenel(1,j)
        xAllts(:,j) = (xAllts(:,j) - min_kenel(1,j)) / (max_kernel(1,j) - min_kenel(1,j)) * 2 - 1;
    else
        xAllts(:,j) = 0;
    end
    
end  

xAllts(isnan(xAllts)) = 0;

model_test = fitrsvm(xAllts, y_data);

cvmodel_test = crossval(model_test,'kfold',size(xAllts,1));
ypredict_test = kfoldPredict(cvmodel_test);
ypredict1_test = ((ypredict_test + 1) / 2) * (max_data - min_data) + min_data;
y1_test = ((y_data + 1) / 2) * (max_data - min_data)+ min_data;

mse_test=mse(ypredict1_test(end-length_test+1:end,1) - y1_test(end-length_test+1:end,1))^.5;

