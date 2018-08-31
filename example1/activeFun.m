%% 3 types of activation functions
function y = activeFun(x,activeType) 
switch activeType
    case 'tansig'
        y = tansig(x);
    case 'logsig'
        y = logsig(x);
    case 'purelin'
        y = purelin(x);
end