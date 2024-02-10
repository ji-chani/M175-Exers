% Bairstow's Methods of finding Multiple Roots
% uses the JUMP-based stopping criterion

%% PREAMBLE  (run ONLY at first)
clc
clear

% defined symbolic variables
syms x

% defined function
% func = x^6 - x^4 - x^3 - 1;
% func = 3*x^6 - 17*x^5 + 46*x^4 - 102*x^3 + 148*x^2 - 136*x + 48;
func = x^5 - 1;

%% Initializing global variables

func_coeffs = sym2poly(func);
a = flip(func_coeffs);  % reverse order (a0x^0 + a1x + a2x^2 + ...)

% degree of polynomial
n = length(func_coeffs) - 1;

% initial values for u and v; D(x) = x^2 + ux + v
u = -0.5;
v = -1.5;

% for halting criterion
max_iteration = 100;
ErrorTol = 10^(-6);

% arrays of coefficients
b = zeros(n+1, 1);
f = zeros(n+1, 1);

%% Bairstow's Methods

% last two coefficients
b(n+1) = 0;
b(n) = 0;
f(n+1) = 0;
f(n) = 0;

% iteration counter
iter_count = 0;

% updating table
table = zeros(max_iteration, 5);

% placeholder for estimates (for rel_jump calculation)
UV = [nan; nan];

% table title
fprintf('%s \t\t %s \t %s \t\t %s \t %s \n','n', 'u_n', 'rel jump (u)', 'v_n', 'rel_jump (v)')

while iter_count <= max_iteration
    
    % remaining coefficients
    for k = n-1:-1:1
        b(k) = a(k+2) - u*b(k+1) - v*b(k+2);
        f(k) = b(k+2) - u*f(k+1) - v*f(k+2);
    end

    % remainder constants
    c = a(2) - u*b(1) - v*b(2);
    g = b(2) - u*f(1) - v*f(2);
    d = a(1) - v*b(1);
    h = b(1) - v*f(1);

    %% updating values of u and v
    
    % needed matrices/vectors
    UVold = UV;
    UV = [u; v];
    CD = [c; d];
    HG = [-h, g; -g*v, g*u-h];
    denom = v*g^2+ h*(h - u*g);

    % new estimates
    UVnew = UV - (1/denom) * HG * CD;
    u = UVnew(1);
    v = UVnew(2);

    %% Halting criterion process

    % relative errors
    if iter_count >= 1
        rel_jump = abs(UVold - UV) ./ abs(UVold);
    else
        rel_jump = [nan, nan];
    end
    error = max(rel_jump);

    % updates table
    table(iter_count+1, :) = [iter_count, UV(1), rel_jump(1), UV(2), rel_jump(2)];
    if iter_count >= 1
        fprintf('%d \t %.6f \t %.6E \t %.6f \t %.6E \n', iter_count, UV(1), rel_jump(1), UV(2), rel_jump(2))
    else
        fprintf('%d \t %.6f \t\t\t %.6E \t %.6f \t %.6E \n', iter_count, UV(1), rel_jump(1), UV(2), rel_jump(2))
    end

    if error < ErrorTol
        break
    end
    
    iter_count = iter_count+1;
end

%% Roots and Display Results

% obtaining root
r_plus = 2*v/(-u - sqrt(u^2 - 4*v));
r_min = 2*v/(-u + sqrt(u^2 - 4*v));

% function evaluation of roots
f_rplus = double(subs(func, r_plus));
f_rmin = double(subs(func, r_min));

% presented_table = transpose(table);  % for printing purposes
% fprintf('%s \t %s \t %s \t %s \t %s \n','n', 'u_n', 'rel jump (u)', 'v_n', 'rel_jump (v)')
% fprintf('%d \t %.6f \t %.6E \t %.6f \t %.6E \n', presented_table(:, 1:iter_count+1))
fprintf('Our approximate quadratic factor is x^2 %0.6f x  %+0.6f \n', u, v)
fprintf('with roots %0.6f %+0.6f i and %0.6f %+0.6f i. \n', real(r_plus), imag(r_plus), real(r_min), imag(r_min))
fprintf('\n The respective function values at these estimated roots are \n %0.6E and %0.6E. \n\n\n', f_rplus, f_rmin)

%% Pre-processes for Deflation (run ONLY at first)

% deflation counter
def_count = 1;

% root counter
root_count = 0;

% array of roots
root = zeros(1, n);
