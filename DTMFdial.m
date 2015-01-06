function xx = DTMFdial(keyNames,fs)
%DTMFDIAL   create a signal vector of tones that will dial a DTMF (Touch
%           Tone) telephone system.
%
% usage:  xx = DTMFdial(keyNames,fs)
%   keynames = vector of CHAR containing valid key names
%         fs = sampling frequency
%         xx = signal vector that is the concatenation of DTMF tones.
%
freq = 0:1/fs:.2;
TT.keys = ['1', '2', '3';
    '4','5','6';
    '7','8','9';
    '*','0','#';];

TT.colTones = ones(4,1)*[1209,1336,1477];
TT.rowTones = [697;770;852;941]*ones(1,3);
TT.keyTones = TT.colTones.*TT.rowTones;
xx = [];
for dum = 1:length(keyNames)
    [ii,jj] = find(keyNames(dum)==TT.keys);
    xx = [xx, cos(2*pi*TT.rowTones(ii)*freq)+cos(2*pi*TT.colTones(ii,jj)*freq)];
    xx = [xx,zeros(1,800)];
end
soundsc(xx,fs);