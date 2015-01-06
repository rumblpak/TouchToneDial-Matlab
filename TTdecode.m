function dkeys = TTdecode(dmat,TT)

dkeys='';
fc=[TT.rowTones(:,1)' TT.colTones(1,:)];
for sample = dmat'
    if sum(sample) == 0
        dkeys = [dkeys 'Z'];
    elseif sum(sample) ~= 2
        dkeys = [dkeys 'X'];
    elseif sum(sample(1:4)) ~= 1
        dkeys = [dkeys 'X'];
    else
        rowFreq = min(fc(find(sample)));
        colFreq = max(fc(find(sample)));
        rowNum = find(rowFreq == TT.rowTones(:,1));
        colNum = find(colFreq == TT.colTones(1,:));
        dkeys = [dkeys TT.keys(rowNum,colNum)];
    end
end
dkeys = dkeys(find(diff(abs(dkeys))~=0));

if (dkeys(1) == 'X')
    dkeys = dkeys(2:end);
end
if (dkeys(end) == 'X')
    dkeys = dkeys(1:end-1);
end
for Xloc = find(dkeys=='X')
    Xloc = find(dkeys=='X'); %fix for Xloc values changing after removal
    Xloc = Xloc(1);
    if (dkeys(Xloc-1) == 'Z' || (dkeys(Xloc+1) == 'Z' ))
        dkeys = [dkeys(1:Xloc-1) dkeys(Xloc+1:end)];
    end
end

dkeys = dkeys(find(dkeys ~= 'Z'));
