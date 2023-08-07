class Range():
    def __init__(self, lower, upper):
        self.lb = lower
        self.ub = upper
    
    def in_range(self, val):
        return (val >= self.lb) and (val <= self.ub)
    
def convert_new_range(data:float, old_range:Range, range_pct:Range) -> float:
    return ((data - old_range.lb)/(old_range.ub - old_range.lb)) * (range_pct.ub - range_pct.lb) + range_pct.lb    

def convert_relative(data):
    return convert_new_range(data, Range(data.min(), data.max()), Range(0,1))