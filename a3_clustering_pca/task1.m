clear ; close all; clc
%% load & prepare data
[features, featureTitles] = loadCSVData('house_data.csv');

X = [
    normalizeFeatures(features(:, 1:13)), ...
    normalizeFeatures(features(:, 15:end)), ...
    onehotEncode(features(:, 14)) %zipcode
    ];
X = [
    normalizeFeatures(features(:, 13:17))
    ];

%% find good number of clusters using elbow plot
max_iters = 40;
cost_history = [];
N = 20;
for K = 1:15
    [centroids, y, cost] = runkMeansNtimes(X, K, N, max_iters, false);
    cost_history = [cost_history, cost];
end

plot(1:15, cost_history)