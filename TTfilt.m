function hmat = TTfilt(fcent, M, fs)

window = 0.07; %amount of passband on each side of a freq
for k = 1:length(fcent)
    omegaH = (2*pi*fcent(k))/fs;
    while(omegaH > pi)
        omegaH = omegaH - (2*pi);
    end
    hmat(:,k) = LancBPF(max([-pi omegaH-window]), min([omegaH+window pi]), M);
end