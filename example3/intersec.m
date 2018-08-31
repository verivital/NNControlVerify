function NNinputd = intersec(NNinput, yk)
    t = 1;
    for i = 1:length(NNinput)
        NNpA = [-1 0 0; 1 0 0; 0 -1 0; 0 1 0; 0 0 -1; 0 0 1];
        NNpb = [-NNinput{i}.min(1); NNinput{i}.max(1);...
            -NNinput{i}.min(2); NNinput{i}.max(2); ...
            -NNinput{i}.min(3); NNinput{i}.max(3)];
        A = [NNpA;[zeros(size(yk.A, 1),1),yk.A]];
        b = [NNpb;yk.b];
        P = Polyhedron('A', A, 'b', b, 'Ae', [], 'be', []);
        if ~P.isEmptySet()
            NNinputd{t} = NNinput{i};
            t = t + 1;
        end       
    end
end