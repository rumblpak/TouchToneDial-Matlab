function xx = dtmfdial(keyNames,fs)

dtmf.keys = ['1','2','3','A';
           '4','5','6','B';
           '7','8','9','C';
           '*','0','#','D'];

dtmf.colTones = ones(4,1)*[1209,1336,1477,1633];
dtmf.rowTones = [697;770;852;941]*ones(1,4);
dur = .2;
del = .1;
xx = zeros(1,floor(fs*del));
for k=1:length(keyNames)
    [ii,jj] = find(keyNames(k) == dtmf.keys);
    if (~length(ii) || ~length(jj))
        error('Bad input detected')
        break;
    end
    tt = 0:(1/fs):dur;
    sig1 = real(exp(j*2*pi*dtmf.rowTones(ii)*tt));
    sig2 = real(exp(j*2*pi*dtmf.colTones(1,jj)*tt));
    tone = sig1+sig2;
    xx = [xx tone zeros(1,floor(fs*del))];
end