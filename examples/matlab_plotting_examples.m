%% MATLAB Scientific Plotting Examples
% Examples demonstrating publication-quality figures using MATLAB
% Similar to the matplotlib examples in the Python version

% Clear workspace and apply plotting configuration
clear; clc; close all;

% Add the ../src folder to the MATLAB search path to load blue-white-red colormap
addpath('../src');

% Font Sizes
SMALL_SIZE = 8;
MIDDLE_SIZE = 10;
LARGE_SIZE = 12;
CONTOUR_LEVELS = 100;
SAVE_DIR = 'figures/';


%% Example 1: Basic Line Plot
% Create figure with specific size (4x3 inches equivalent)
h1 = figure('Color', 'w', 'Units', 'inches', 'Position', [0 0 4 3]);
set(h1, 'DefaultTextInterpreter', 'latex')
set(h1,'defaultAxesTickLabelInterpreter','latex');
set(h1,'defaultLegendInterpreter','latex');
set(h1,'defaultColorbarTickLabelInterpreter','latex');
set(h1,'defaultAxesFontSize',MIDDLE_SIZE)
set(h1,'defaultAxesFontName', 'Helvetica')
set(h1, 'DefaultLineMarkerSize',5)

% 1. Generate sample data
x = linspace(0, 2*pi, 200);
y_truth = sin(x);
y_emulator1 = cos(x);
y_emulator2 = sin(x) + 0.1*cos(2*x);

% 2. Plot data
plot(x, y_truth, '-k', 'DisplayName', 'Truth');
hold on;
plot(x, y_emulator1, ':r', 'DisplayName', 'Model 1');
plot(x, y_emulator2, '--b', 'DisplayName', 'Model 2');

% 3. Labels, legend, and title
xlabel('Time', FontSize = MIDDLE_SIZE);
ylabel('Amplitude',  FontSize = MIDDLE_SIZE);
legend('Location', 'best', 'Box', 'off');  % Frameless legend
title('Line Plot',  FontSize = LARGE_SIZE);

% Set axis limits 
xlim([0, 2*pi]);
ylim([-1.2, 1.2]);

% 4. Save
exportgraphics(h1, fullfile(SAVE_DIR, 'matlab_sample_line.svg'));


%% Example 2: Multi-Panel Contour Plot

% Create figure with specific size (8x4 inches equivalent)
h2 = figure('Color', 'w', 'Units', 'inches', 'Position', [0 0 8 4]);
set(h2, 'DefaultTextInterpreter', 'latex')
set(h2,'defaultAxesTickLabelInterpreter','latex');
set(h2,'defaultLegendInterpreter','latex');
set(h2,'defaultColorbarTickLabelInterpreter','latex');
set(h2,'defaultAxesFontSize',MIDDLE_SIZE)
set(h2,'defaultAxesFontName', 'Helvetica')
set(h2, 'DefaultLineMarkerSize',5)

% Create tiled chart layout for displaying subplots
t = tiledlayout(h2,1,2,'TileIndexing','rowmajor','TileSpacing','compact','Padding','tight');

% 1. Generate sample data
x = linspace(0, 2*pi, 128);
y = linspace(0, 2*pi, 128);
[X, Y] = meshgrid(x, y);
Z1 = sin(X) .* cos(Y);
Z2 = sin(2*X) .* cos(2*Y);

% 2. Plot data Panel A
tt = nexttile(1);

[s,ss] = contourf(X, Y, Z1, CONTOUR_LEVELS, 'LineStyle', 'none', 'Edgecolor','none');
limS = max(abs(Z1(:)));
mapS1 =  b2r(-limS,limS);
colormap(mapS1);  % Use b2r colormap
clim([-limS limS]);
colorbar;

title('$\omega$', FontSize = LARGE_SIZE);
xlabel('X', FontSize = MIDDLE_SIZE);
ylabel('Y', FontSize = MIDDLE_SIZE);
axis equal;
xlim([0, 2*pi]);
ylim([0, 2*pi]);

% Set x/y-ticks and labels
xticks([0, pi, 2*pi]);
xticklabels({'0', '\pi', '2\pi'});
yticks([0, pi, 2*pi]);
yticklabels({'0', '\pi', '2\pi'});

% 2. Plot data Panel A
tt = nexttile(2);
[s,ss] = contourf(X, Y, Z2, CONTOUR_LEVELS, 'LineStyle', 'none', 'Edgecolor','none');
limS = max(abs(Z2(:)));
mapS1 =  b2r(-limS,limS);
colormap(mapS1);  % Use blue-white-red colormap
clim([-limS limS]);
colorbar;

title('$\tau_{12}$', FontSize = LARGE_SIZE);
xlabel('X', FontSize = MIDDLE_SIZE);
ylabel('Y', FontSize = MIDDLE_SIZE);
axis equal;
xlim([0, 2*pi]);
ylim([0, 2*pi]);

% Set x/y-ticks and labels
xticks([0, pi, 2*pi]);
xticklabels({'0', '\pi', '2\pi'});
yticks([0, pi, 2*pi]);
yticklabels({'0', '\pi', '2\pi'});
% 
% % Save figure
exportgraphics(h2, fullfile(SAVE_DIR, 'matlab_sample_contour.svg'), 'Resolution', 600);