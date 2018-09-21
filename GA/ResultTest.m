function fitness = ResultTest(chrom,Flight,Gate)

for i = 1:size(Flight,1)
    if (Flight{i,2}==19)
        Flight{i,3} = 1440;
    elseif (Flight{i,2}==20)
        Flight{i,3} = Flight{i,3};
    end
    if (Flight{i,7}==20)
        Flight{i,8} = Flight{i,8};
    elseif (Flight{i,7}==21)
        Flight{i,8} = 2880;
    end
end
GateUSEDTime_re = zeros(size(Gate,1),1);
for j = 1:size(Flight,1)
    gate = chrom.Gate(j);
    if(gate~=0)
        GateUSEDTime_re(gate) = GateUSEDTime_re(gate)+(Flight{j,8}-Flight{j,3});
    end
end
GateNum = 0;
for k = 1:size(GateUSEDTime_re,1)
    if(GateUSEDTime_re(k)~=0)
        GateNum = GateNum+1;
    end
end

GateUSEDProbability = GateUSEDTime_re/1440
AverageProbability = sum(GateUSEDProbability)/GateNum



    
