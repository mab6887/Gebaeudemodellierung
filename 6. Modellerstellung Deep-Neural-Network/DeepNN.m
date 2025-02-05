% Load your data
% Assuming you have your input data in 'inputs' and output data in 'targets'
% inputs should be a matrix of size [19, numSamples]
% targets should be a matrix of size [11, numSamples]

D = readtable("DataDeepNN.txt")

inputs = D{:,2:20}

targets = D{:,21:31}


sIv1 = datetime('01-Sep-2023 00:15:00');
eIv1 = datetime('15-Sep-2023 00:00:00');
sIv2 = datetime('29-Sep-2023 00:15:00');
eIv2 = datetime('13-Oct-2023 00:00:00');
sIv3 = datetime('27-Oct-2023 00:15:00');
eIv3 = datetime('17-Nov-2023 09:15:00');
sIv4 = datetime('15-Dec-2023 00:15:00');
eIv4 = datetime('29-Dec-2023 00:00:00');
sIv5 = datetime('12-Jan-2024 00:15:00');
eIv5 = datetime('26-Jan-2024 00:00:00');
sIv6 = datetime('09-Feb-2024 00:15:00');
eIv6 = datetime('21-Feb-2024 11:45:00');
sIv7 = datetime('08-Mar-2024 00:15:00');
eIv7 = datetime('22-Mar-2024 00:00:00');
sIv8 = datetime('05-Apr-2024 00:15:00');
eIv8 = datetime('19-Apr-2024 00:00:00');

                trainInd = [find(D.timestamps >= sIv1 & D.timestamps <= eIv1) 
                            find(D.timestamps >= sIv2 & D.timestamps <= eIv2)
                            find(D.timestamps >= sIv3 & D.timestamps <= eIv3)
                            find(D.timestamps >= sIv4 & D.timestamps <= eIv4)
                            find(D.timestamps >= sIv5 & D.timestamps <= eIv5)
                            find(D.timestamps >= sIv6 & D.timestamps <= eIv6)
                            find(D.timestamps >= sIv7 & D.timestamps <= eIv7)
                            find(D.timestamps >= sIv8 & D.timestamps <= eIv8)]

%Validierung

sIv1 = datetime('15-Sep-2023 00:15:00');
eIv1 = datetime('22-Sep-2023 00:00:00');
sIv2 = datetime('13-Oct-2023 00:15:00');
eIv2 = datetime('20-Oct-2023 00:00:00');
sIv3 = datetime('01-Dec-2023 12:15:00');
eIv3 = datetime('08-Dec-2023 00:00:00');
sIv4 = datetime('29-Dec-2023 00:15:00');
eIv4 = datetime('05-Jan-2024 00:00:00');
sIv5 = datetime('26-Jan-2024 00:15:00');
eIv5 = datetime('02-Feb-2024 00:00:00');
sIv6 = datetime('23-Feb-2024 12:15:00');
eIv6 = datetime('28-Feb-2024 23:45:00');
sIv7 = datetime('22-Mar-2024 00:15:00');
eIv7 = datetime('29-Mar-2024 00:00:00');
sIv8 = datetime('19-Apr-2024 00:15:00');
eIv8 = datetime('26-Apr-2024 00:00:00');

valInd =                    [find(D.timestamps >= sIv1 & D.timestamps <= eIv1) 
                            find(D.timestamps >= sIv2 & D.timestamps <= eIv2)
                            find(D.timestamps >= sIv3 & D.timestamps <= eIv3)
                            find(D.timestamps >= sIv4 & D.timestamps <= eIv4)
                            find(D.timestamps >= sIv5 & D.timestamps <= eIv5)
                            find(D.timestamps >= sIv6 & D.timestamps <= eIv6)
                            find(D.timestamps >= sIv7 & D.timestamps <= eIv7)
                            find(D.timestamps >= sIv8 & D.timestamps <= eIv8)]

%Test

sIv1 = datetime('22-Sep-2023 00:15:00');
eIv1 = datetime('29-Sep-2023 00:00:00');
sIv2 = datetime('20-Oct-2023 00:15:00');
eIv2 = datetime('27-Oct-2023 00:00:00');
sIv3 = datetime('08-Dec-2023 00:15:00');
eIv3 = datetime('15-Dec-2023 00:00:00');
sIv4 = datetime('05-Jan-2024 00:15:00');
eIv4 = datetime('12-Jan-2024 00:00:00');
sIv5 = datetime('02-Feb-2024 00:15:00');
eIv5 = datetime('09-Feb-2024 00:00:00');
sIv6 = datetime('01-Mar-2024 00:15:00');
eIv6 = datetime('08-Mar-2024 00:00:00');
sIv7 = datetime('29-Mar-2024 00:15:00');
eIv7 = datetime('05-Apr-2024 00:00:00');
sIv8 = datetime('26-Apr-2024 00:15:00');
eIv8 = datetime('28-Apr-2024 20:30:00');

                testInd =  [find(D.timestamps >= sIv1 & D.timestamps <= eIv1) 
                            find(D.timestamps >= sIv2 & D.timestamps <= eIv2)
                            find(D.timestamps >= sIv3 & D.timestamps <= eIv3)
                            find(D.timestamps >= sIv4 & D.timestamps <= eIv4)
                            find(D.timestamps >= sIv5 & D.timestamps <= eIv5)
                            find(D.timestamps >= sIv6 & D.timestamps <= eIv6)
                            find(D.timestamps >= sIv7 & D.timestamps <= eIv7)
                            find(D.timestamps >= sIv8 & D.timestamps <= eIv8)]


inputs = inputs'
targets = targets' 

% Define the network architecture
inputSize = 19;
hiddenLayerSize1 = 25; % Size of the first hidden layer
hiddenLayerSize2 = 20; % Size of the second hidden layer
outputSize = 11;

% Create a feedforward neural network
net = feedforwardnet([hiddenLayerSize1, hiddenLayerSize2]);

% Configure the neural network for training
net = configure(net, inputs, targets);

% Setup Division of Data for Training, Validation, Testing
net.divideFcn = 'divideind';  
net.divideMode = 'time';

net.divideParam.trainInd = trainInd;
net.divideParam.valInd = valInd;
net.divideParam.testInd = testInd;


% Set training parameters (optional)
net.trainParam.epochs = 1000; % Number of training epochs
net.trainParam.goal = 1e-6; % Performance goal

% Train the neural network
[net, tr] = train(net, inputs, targets);

% View the network
view(net);


% Test the network
outputs = net(inputs);
errors = gsubtract(targets, outputs);
performance = perform(net, targets, outputs);

% Display performance
fprintf('Training performance: %f\n', performance);

% Plot training performance
figure, plotperform(tr);

%Einfügen von Plots die berechnete Ergebnisse mit gemessenen vergleichen
% Compare computed outputs to measured ones
% Extract test outputs and targets
testOutputs = outputs(:, testInd);
testTargets = targets(:, testInd);

% Save the trained network
save('2_layer_network.mat', 'net');
%%

% Plot each target vs. output

for i = 1:size(testTargets, 1)
    figure;
    plot(testTargets(i, :), 'b');
    hold on;
    plot(testOutputs(i, :), 'r');
    hold off;
    title(['Target vs. Output for Output Neuron ', num2str(i)]);
    legend('Measured', 'Computed');
    xlabel('Sample');
    ylabel('Value');
end


%Computing time fürs Netz: 1:45 min