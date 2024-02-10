% The Fixed Point Iteration Method
% applied with Aitken-I (integrated) routine
% uses JUMP-based stopping criterion

%% PREAMBLE
clc
clear

% defined symbolic variable
syms x

%% Initializing global variables

% fixed point iteration function and original function
fpIter_func = 1 + x - (1/5)*x^2;
% func = ...

% initial guess
x_n = 2.5;

% for halting criterion
max_iteration = 100;
ErrorTol = 10^(-16);

% updating table
table = zeros(max_iteration, 4);

%% Fixed Point Iteration + Aitken-I routine

% iteration counter
iter_count = 0;

% table title
fprintf('%s \t\t %s \t\t %s \t %s \n', 'n', 'x_n', 'rel jump', '\\lambda_n')

while iter_count <= max_iteration

    % approx asymptotic error constant
    if iter_count >= 2
%         new_est = double(subs(fpIter_func, x_n));
        lambda = (x_n - prev_est)/(prev_est - prevprev_est);
    else
        lambda = '';
    end

    % saving previous estimates
    if iter_count >= 1
        prevprev_est = prev_est;
    end
    prev_est = x_n;

    % new estimate
    if rem(iter_count+1, 3) == 0
        x_n = prev_est + (lambda/(1-lambda)) * (prev_est - prevprev_est);
    else
        x_n = double(subs(fpIter_func, x_n));
    end

    % relative jump
    if iter_count >= 1
        rel_jump = abs(prev_est - prevprev_est)/abs(prevprev_est);
    else
        rel_jump = '';
    end

    % print results
    fprintf('%d \t %0.6f \t %0.6e \t %0.6f \n',iter_count, prev_est, rel_jump, lambda)

    % halting criterion
    if (rel_jump < ErrorTol)
        break
    end

    % update iteration count
    iter_count = iter_count + 1;
end

