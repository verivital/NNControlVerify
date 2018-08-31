function output = quickConvexHull(input)
vertex = input{1}.V;
if length(input) > 1
    for i=2:1:length(input)
        vertex = [vertex;input{i}.V];
    end
end

vertexIndex = convhulln(vertex);
vertexIndex = unique(vertexIndex(:));

for i = 1:1:length(vertexIndex)
    vertexHull(i,:) = vertex(vertexIndex(i),:);
end
output = Polyhedron('V',vertexHull);





