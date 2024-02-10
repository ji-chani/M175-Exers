% Gaussian Elimination with Partial Pivoting

%% PREAMBLE

clc
clear

%% Initializing Global Variables

% system = [2/3, 2/7, 1/5 , 43/15;
%     1/3, 1/7, -1/2, 5/6;
%     1/5, -3/7, 2/5, -12/5];

system = [4 3 2 1 1;
    3 4 3 2 1;
    2 3 4 3 -1;
    1 2 3 4 -1];

% k digit rounding arithmetic
r = 4;

% number of rows and columns
eq = size(system, 1);
var = size(system, 2) - 1;

% row tracker
row_track = zeros(1, eq);
for j = 1:eq
    row_track(j) = j;
end

system = round(system, 4);
%% Partial Pivoting Method

fprintf('The given matrix is \n')
disp(system)
fprintf('Applying Gaussian Elimination with Partial Pivoting, \n we have the ff results: \n\n')


for col = 1:var-1  % iterates over each column

    % update remaining rows to consider for ERO
    if col == 1
        rem_rows = row_track;
    else
        rem_rows(rem_rows == max_rowidx) = [];
    end

    % maximum magnitude for column "col" (pivot constant)
    pivot_const = max(abs(system(rem_rows, col)));

    % maximum index (initialized)
    max_rowidx = rem_rows(1);
    
    for row = rem_rows
        
        % locating correct row index of pivot constant
        if abs(system(row, col)) == pivot_const
            max_rowidx = row;
        end
    end

    % switching row with max index
    dummy = row_track(col);
    row_track(col) = row_track(max_rowidx);
    row_track(max_rowidx) = dummy;

    %% elementary row operations

    for elem_row = rem_rows

        if elem_row ~= max_rowidx

            % row constant
            const = -system(elem_row, col)/system(max_rowidx, col);

            % pivot row
            pivot_row = system(max_rowidx, :);
            
            % update elem_row
            system(elem_row, :) = system(elem_row, :) + const*pivot_row;
        end
    end

    % print updated system
    if col == 1
        system_arr = zeros(eq, var+1);  % arranged system
    end

    row_id = 1;
    for track_id = row_track
        system_arr(track_id,:) = system(row_id, :);
        row_id = row_id + 1;
    end

    fprintf('After pass %d, the updated matrix is \n', col)
    disp(system_arr)
end

%% Solving for system (Back Substitution)

% solution placeholder
soln = zeros(var, 1);

for sol_row = eq:-1:1
    
    if sol_row == eq
        soln(sol_row) = system_arr(eq, var+1)/system_arr(eq, var);
    else
        dot_prod = system_arr(sol_row, 1:var) * soln;
        soln(sol_row) = (system_arr(sol_row, var+1) - dot_prod) / system_arr(sol_row, sol_row);
    end
end

fprintf('Performing back substitution will yield the solutions \n')
for soln_id = 1:var
    fprintf('x_%d = %0.4f \n', soln_id, soln(soln_id))
end
