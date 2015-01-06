function keys = TTmain(xx,M,fs)

TT.keys = ['1','2','3','A';
           '4','5','6','B';
           '7','8','9','C';
           '*','0','#','D'];

TT.colTones = ones(4,1)*[1209,1336,1477,1633];
TT.rowTones = [697;770;852;941]*ones(1,4);
fc = [TT.rowTones(:,1)' TT.colTones(1,:)];
hmat = TTfilt(fc,M,fs);
L=12;
P=15;
thresh = .1;
dmat = TTdetect(xx, hmat, L, P, thresh);
keys = TTdecode(dmat,TT);
