# The Bisection Method
# an interval/bracketing-based method for finding a root of a given function

# packages
import numpy as np
from tabulate import tabulate

# ----- DEFINING PARAMETERS

# function definition
def func(x):
    return np.sin(x)

# initial endpoints
a = 2
b = 3.5

# parameters for halting criterion
error_tol = 10**(-6)
max_iteration = 100

# table placeholder
table = np.zeros((max_iteration, 5))

# ------ BISECTION METHOD
iter_count = 0
while iter_count < max_iteration:

    # function value at current endpoints
    fa, fb = func(a), func(b)

    # new estimate
    c = (a+b)/2
    fc = func(c)

    # save values in table
    table[iter_count, :] = [iter_count, a, b, c, b-a]

    # stopping criterion
    from halting_criteria import halt_interval, halt_jump, halt_fvalue
    if fc == 0 or halt_fvalue(new_estimate=c, function=func, error_tolerance=error_tol):
        iter_count += 1
        break
    elif fa*fc < 0:
        b = c
    else:
        a = c
    
    iter_count += 1

# ------ PRINTING RESULTS
table_header = ['n', 'a_n', 'b_n', 'c_n', 'b_n-a_n']
print(tabulate(table[:iter_count, :], headers=table_header, numalign='right'))
print(f'Root is {c:.2f} after {iter_count-1} iterations.')
print(f'Note that the function value at the estimate is {fc:.3e}.')


