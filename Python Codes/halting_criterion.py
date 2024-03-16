# CONTAINS FUNCTIONS FOR HALTING CRITERION
# interval-based, jump-based, and function value-based


def halt_interval(interval_length, error_tolerance):
    if interval_length < error_tolerance:
        return True
    return False

def halt_jump(prev_estimate, new_estimate, error_tolerance):
    if abs((prev_estimate-new_estimate)/new_estimate) < error_tolerance:
        return True
    return False

def halt_fvalue(new_estimate, function, error_tolerance):
    if abs(function(new_estimate)) < error_tolerance:
        return True
    return False
