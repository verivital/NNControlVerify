%% Partition 2D input set
function input = inputDiscretize(input_min,input_max,num_division)
for i = 1:1:2
    step = (input_max-input_min)/num_division(i);
    input_sequence{i} = input_min(i):step:input_max(i);
    if input_max(i) > input_sequence{i}(end)
        input_sequence{i} = [input_sequence{i},input_max(i)];
    end
end

k=0;
for i = 1:1:length(input_sequence{1})-1
    for j = 1:1:length(input_sequence{2})-1
        k = k+1;
        input{k}.min(1) = input_sequence{1}(i);
        input{k}.min(2) = input_sequence{2}(j);
        input{k}.max(1) = input_sequence{1}(i+1);
        input{k}.max(2) = input_sequence{2}(j+1);
    end
end

