import copy

l = [1,2,3,4]

deep = copy.copy(l)
shallow = copy.deepcopy(l)

l[0] = 10
print(l)
print(deep)
print(shallow)
