function Rd = RdDiscretize(rmin, rmax, numdr)

step = (rmax-rmin)/numdr;
rsequence = rmin:step:rmax; %step(i) by XD
if rmax > rsequence(end)
    rsequence = [rsequence,rmax];
end
for i = 1:1:length(rsequence)-1
    Rd{i}.min = rsequence(i);
    Rd{i}.max = rsequence(i+1);
end