%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPML113
% Project Title: Implementation of Group Method of Data Handling in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function PlotResults(Targets, Outputs, Title)

    Errors = Targets - Outputs;
    MSE = mean(Errors.^2);
    RMSE = sqrt(MSE);
    MAE=mean(abs(Errors));
    MARE=mean(abs(Errors/Targets));
    MAPE=mean(abs(Errors)./Targets)*100;
    ErrorMean = mean(Errors);
    ErrorStd = std(Errors);
    
    subplot(2,2,[1 2]);
    plot(Targets,'-.bo');
    hold on;
    plot(Outputs,'-.rs','MarkerFaceColor','r');
    legend({'Targets','Outputs'});
    ylabel('Targets and Outputs');
%     ylim([0 1.2])
    grid on;
    title(Title);
    
    subplot(2,2,[3 4]);
    plot(Errors);
    title(['MSE = ' num2str(MSE) ', RMSE = ' num2str(RMSE) ',MAE = ' num2str(MAE)  ', MARE = ' num2str(MARE)   ', MAPE = ' num2str(MAPE)]);
    ylabel('Errors');
    grid on;
    
%     subplot(2,2,4);
%     histfit(Errors, 50);
%     title(['Error Mean = ' num2str(ErrorMean) ', Error StD = ' num2str(ErrorStd)]);

end