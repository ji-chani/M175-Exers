% The Fixed Point Iteration Method
% uses FUNCTION VALUE-based stopping criterion

%% Preamble
clc
clear

% defined symbolic variable
syms x

%% Initializing global variables

% fixed point iteration function
fpIter_func = (1/2)*(x + 5/x);
func = x^2 - 5;

% initial guess
x_n = 1;

% for halting criterion
max_iteration = 100;
ErrorTol = 10^(-3);

% updating table
table = zeros(max_iteration, 4);

%% Fixed-Point Iteration Method

% iteration counter
iter_count = 0;
while iter_count <= max_iteration

    % previous and new estimate
    prev_est = x_n;
    x_n = double(subs(fpIter_func, x_n));
    
    % function evaluation
    f_x = abs(double(subs(func, x_n)));

    % relative jump
    rel_jump = abs((x_n - prev_est)/prev_est);
    
    % updates table
    table(iter_count+1, :) = [iter_count, prev_est, x_n, f_x];

    if f_x < ErrorTol
        f_x = abs(double(subs(func, x_n)));
        break
    end
    
    iter_count = iter_count + 1;
end

%% Display results

presented_table = transpose(table);  % for printing purposes
fprintf('%s \t %s \t\t %s \t %s \n','n', 'x_n', 'x_(n+1)', '|f(x_n+1)|')
fprintf('%d \t %.6f \t %.6f \t %E \n', presented_table(:, 2:iter_count+1))
fprintf('Root is %.10f after %i iterations. \n', x_n, iter_count)
fprintf('Note that the absolute function value at the estimate is %.6E. \n', f_x)
