clear ; close all; clc
%% load & prepare data
[features, featureTitles] = loadCSVData('house_data.csv');

indexes = [1:6. 9:13, 16:19];
X = normalizeFeatures(features(:, indexes));
labels = featureTitles(indexes);

%% find good number of clusters using elbow plot
max_iters = 20;
cost_history = [];
N = 20;
for K = 2:20
    [centroids, y, cost] = runkMeansNtimes(X, K, N, max_iters, false);
    cost_history = [cost_history, cost];
end

plot(2:20, cost_history)
title('elbow plot of kmeans algorithm')
xlabel('number of clusters')
ylabel('cost function (distortion)')


%% run clsutering with K=6 and plot the cluster results
K = 6;
[centroids, y, cost] = runkMeansNtimes(X, K, N, max_iters, false);

palette = hsv(K + 1);
colors = palette(y, :);
% Plot some example data
scatter(X(:, 1), X(:, 2), 10, colors, 'filled');
title('clustering result');
xlabel(labels(1));
ylabel(labels(2));
figure;
scatter(X(:, 2), X(:, 3), 10, colors, 'filled');
title('clustering result');
xlabel(labels(2));
ylabel(labels(3));
figure;
scatter(X(:, 2), X(:, 4), 10, colors, 'filled');
title('clustering result');
xlabel(labels(2));
ylabel(labels(4));
figure;
scatter3(X(:, 12), X(:, 13), X(:, 1), 10, colors, 'filled');
title('clustering result');
xlabel(labels(12));
ylabel(labels(13));
zlabel(labels(1));


%% characterize clusters by analysing the variance per feature
% TODO only show top 5 or so, and also display mean of these features as
% well as total clsuter content (%)
for k = 1:K
    variance = var(X(y==k, :));
    [~, indices] = sort(variance);
    fprintf('cluster %d variances:\n', k);
    for i = indices
        fprintf('\t%-15s: %.2f\n', labels{i}, variance(i));
    end
    fprintf('\n');
end
