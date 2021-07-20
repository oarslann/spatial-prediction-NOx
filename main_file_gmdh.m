%% Spatial Prediction of Air Pollution Parameter NOx based on GMDH-type Neural Network

A_station_data=csvread('A_station_data.csv');
B_station_data=csvread('B_station_data.csv');
C_station_data=csvread('C_station_data.csv');
D_station_data=csvread('D_station_data.csv');

A_NOX=A_station_data(:,3);
B_NOX=B_station_data(:,5);
C_NOX=C_station_data(:,5);
D_NOX=D_station_data(:,5);

Input_Data=A_station_data(:,[1:2,4:8]);
Inputs=Input_Data';
Targets=A_NOX';

rng(1);
nData = size(Inputs,2);
Perm = randperm(nData);

% Train Data
pTrain = 0.8;
nTrainData = round(pTrain*nData);
TrainInd = Perm(1:nTrainData);
TrainInputs = Inputs(:,TrainInd);
TrainTargets = Targets(:,TrainInd);

% Test Data
pTest = 1 - pTrain;
nTestData = nData - nTrainData;
TestInd = Perm(nTrainData+1:end);
TestInputs = Inputs(:,TestInd);
TestTargets = Targets(:,TestInd);

%% Create and Train GMDH Network

params.MaxLayerNeurons = 5;   % Maximum Number of Neurons in a Layer
params.MaxLayers = 5;          % Maximum Number of Layers
params.alpha = 0.7;            % Selection Pressure (in Layers)
params.pTrain = 0.8;          % Train Ratio (vs. Validation Ratio)
gmdh = GMDH(params, TrainInputs, TrainTargets);

%% Evaluate GMDH Network

Outputs = ApplyGMDH(gmdh, Inputs);
TrainOutputs = Outputs(:,TrainInd);
TestOutputs = Outputs(:,TestInd);

% Coefficients
gmdh.Layers{1}.vars
gmdh.Layers{1}.c

%%
disp('Type "gmdh.Layers" to see the layers'' info.');
disp(' ');
% 
close all
figure;
PlotResults(TrainTargets, TrainOutputs, 'Train Data');
% 
figure;
PlotResults(TestTargets, TestOutputs, 'Test Data');
% 
figure;
PlotResults(Targets, Outputs, 'All Data');

if ~isempty(which('plotregression'))
    figure
    plotregression(TrainTargets, TrainOutputs, 'Train Data') 
    xlabel('Actual NOX ')
    ylabel('Predicted NOX ')

  figure;
    plotregression(TestTargets, TestOutputs, 'Test Data')  
    xlabel('Actual NOX')
    ylabel('Predicted NOX')

    figure;
    plotregression(Targets, Outputs, 'All Data') 
    xlabel('Actual NOX')
    ylabel('Predicted NOX')
  
end