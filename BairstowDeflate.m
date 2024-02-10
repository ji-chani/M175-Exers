% This program is used together with Bairstow_jump.m program
% Use Deflation method on a given function

% Run this program after each run of Bairstow_jump.m
% until all roots are obtained.

% after a run of this program, run the Bairstow_jump.m program 
% except the first (PREAMBLE) and last (Pre-processes for Deflation)
% Sections.

%% Deflation Method for Bairstow's Algorithm

% saves obtained roots
root_count = root_count + 1;
root(root_count) = r_plus;
root_count = root_count + 1;
root(root_count) = r_min;

% deflating function
D = (x-r_plus)*(x-r_min);

% deflation process
[rem, func] = polynomialReduce(func, D);
def_count = def_count + 1;

% display reduced function
fprintf('Our deflated function becomes f(x) = \n')
disp(vpa(expand(func),6))

%% Last Two or One Estimates

% degree of polynomial
func_coeffs = sym2poly(func);

%  degree of current polynomial
n = length(func_coeffs) - 1;

% current polynomial is quadratic -> perform quadratic formula
if n == 2
    
    % coefficients of current polynomial
    a = func_coeffs(1);
    b = func_coeffs(2);
    c = func_coeffs(3);
    
    % obtaining root
    r_plus = 2*c/(-b - sqrt(b^2 - 4*a*c));
    r_min = 2*c/(-b + sqrt(b^2 - 4*a*c));
    
    % saves obtained roots
    root_count = root_count + 1;
    root(root_count) = r_plus;
    root_count = root_count + 1;
    root(root_count) = r_min;
    
    % display final roots
    fprintf('Applying the quadratic formula on g, we have the roots \n')
    fprintf('%0.6f %+0.6f i and %0.6f %+0.6f i. \n', real(r_plus), imag(r_plus), real(r_min), imag(r_min)')

    % display all roots
    fprintf('\n Therefore, the estimated roots required are \n')
    for i = 1:length(root)
        fprintf('%0.6f %+0.6e i \n', real(root(i)), imag(root(i)))
    end

% current polynomial is linear
elseif n == 1
    
    % coefficients of current polynomial
    a = func_coeffs(1);
    b = func_coeffs(2);

    % obtaining root
    r = -b/a;

    % saves obtained roots
    root_count = root_count + 1;
    root(root_count) = r;

    % display final root
    fprintf('Solving for the final root of f, we have \n')
    fprintf('%0.6f %+0.6f i. \n', real(r), imag(r))

    % display all roots
    fprintf('\n Therefore, the estimated roots required are \n')
    for i = 1:length(root)
        fprintf('%0.6f %+0.6e i \n', real(root(i)), imag(root(i)))
    end

    % function evaluation of roots
    f_root = double(subs(orig_func, root));
    for i = 1:length(root)
        fprintf('%0.6e %+0.6e i \n', real(f_root(i)), imag(f_root(i)))
    end

else
    fprintf("Performing Bairstow's Method on g, we have \n")
end
