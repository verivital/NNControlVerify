function output = quickConvexHull2(input)
vertex = input{1}.V;
if length(input) > 1
    for i=2:1:length(input)
        vertex = [vertex;input{i}.V];
    end
end

output = Polyhedron('V',[min(vertex); max(vertex)]);
