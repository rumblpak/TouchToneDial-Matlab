function dmat = TTdetect(xx, hmat, L, P, thresh)

i = 1; 
for h = hmat
    yy = conv(h', xx); %filter input
    period = round((1/697)*1860);
    pvals = [];
    plocs = [];
    for start = 1:period:length(yy)
            finish = start + period - 1;
        if finish<=length(yy)
            pvals = [pvals max(yy(start:finish))];
        else
            pvals = [pvals max(yy(start:end))];
        end
    end
    yy = yy.^2; 
    average = ones(1,L)./(L); %make average filter
    yy = conv(average, pvals); %apply the average filter
    yy = yy(1:P:end); %downsample: take every Pth sample
    yy = yy > thresh; %apply threshold
    dmat(:,i) = yy; %
    i = i + 1; 
end