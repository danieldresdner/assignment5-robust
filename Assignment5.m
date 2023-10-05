clear all
clc


% Determine all equilibria
% -------------------------------------------------------------------------

% Compare with Exercise 6.1
% -------------------------
% f = [2*x - (x*y)/(1 + x/6) - 0.2*x^2     
%             -3*y + (x*y)/(1 + x/6)];

syms x y real

f = [2*(y - x) + x*(1 - x^2);
     -2*(y - x) + y*(1 - y^2)];

solutions = solve(f == 0);
equilibria = [double(solutions.x), double(solutions.y)];
numberOfEquilibria = size(equilibria, 1);
dimension = size(equilibria, 2);


% Determine types of equilibria
% -------------------------------------------------------------------------
A = jacobian(f, [x, y]);

eigenValues = zeros(numberOfEquilibria, dimension);
eigenVectors = zeros(dimension, dimension, numberOfEquilibria);
for i=1:numberOfEquilibria
    equilibriumPoint = equilibria(i, :);
    evaluated_A = subs(A, [x, y], equilibriumPoint);
    eigenValues(i,:) = eig(evaluated_A);
    [eigenVectors(:,:,i), ~] = eig(evaluated_A);
end

PrintEigenProperties(equilibria, eigenValues, eigenVectors)

% Compute Bendixson criteria for limit cycles
firstTerm = jacobian(f(1), x);
secondTerm = jacobian(f(2), y);

firstTerm + secondTerm  
solve(firstTerm + secondTerm == 0);


%% ------------------------------------------------------------------------
% Plot phase portrait and trajectories
% -------------------------------------------------------------------------

% f = @(t, X) [2*X(1) - (X(1)*X(2))/(1 + X(1)/6) - 0.2*X(1)^2;      % Exercise
%              -3*X(2) + (X(1)*X(2))/(1 + X(1)/6)];

f = @(t, X) [2*(X(2) - X(1)) + X(1)*(1 - X(1)^2);
     -2*(X(2) - X(1)) + X(2)*(1 - X(2)^2)];

xMin = -3;
xMax = 3;
yMin = -3;
yMax = 3;

x1 = linspace(xMin, xMax, 50);
x2 = linspace(yMin, yMax, 50);

[x, y] = meshgrid(x1, x2);

x1_values = zeros(size(x));
x2_values = zeros(size(y));

t = 0;    
for i=1:numel(x)
    X_dot = f(t, [x(i); y(i)]);
    x1_values(i) = X_dot(1);
    x2_values(i) = X_dot(2);
end

quiver(x, y, x1_values, x2_values, 'r'); figure(gcf)
xlabel('x1')
ylabel('x2')
axis tight equal;
hold on
    
numberOfTrajectories = 60;
time = linspace(0,2*pi,numberOfTrajectories);
radius = 2;
x1_initial = radius*cos(time);
x2_initial = radius*sin(time);

for i=1:numberOfTrajectories
    [ts,ys] = ode45(f,[0,numberOfTrajectories],[x1_initial(i);x2_initial(i)]);
    plot(ys(:,1),ys(:,2), 'b')
    plot(ys(1,1),ys(1,2),'bo', LineWidth=1)         % starting point
    plot(ys(end,1),ys(end,2),'ks', LineWidth=3)     % ending point
end

[eig11x, eig11y] = GetLinePoints([0,0], [-1, 1], xMin, xMax, yMin, yMax);
[eig12x, eig12y] = GetLinePoints([0,0], [1, 1], xMin, xMax, yMin, yMax);

line(eig11x, eig11y, 'Color', "#000000")
line(eig12x, eig12y, 'Color', "#000000")

hold off
legend('$f(x)$','$trajectory$', '$X_0$', '$X_{final}$', '$Eigenvectors$', 'fontsize', 10, 'interpreter', 'latex')
title('Phase portrait of reaction-diffusion model', 'interpreter', 'latex')

