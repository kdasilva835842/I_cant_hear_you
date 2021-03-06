BW = '1/3 octave'; 
N = 14;
F0 = 1000;
Fs = 40000;
oneThirdOctaveFilter = octaveFilter('FilterOrder', N, ...
    'CenterFrequency', F0, 'Bandwidth', BW, 'SampleRate', Fs);
F0 = getANSICenterFrequencies(oneThirdOctaveFilter);
F0(F0<250) = [];
F0(F0>8000) = [];
Nfc = length(F0);
for i=1:Nfc
    oneThirdOctaveFilterBank{i} = octaveFilter('FilterOrder', N, ...
        'CenterFrequency', F0(i), 'Bandwidth', BW, 'SampleRate', Fs); 
end
%%
for i=1:Nfc
    compliant = isStandardCompliant(oneThirdOctaveFilterBank{i}, 'class 0');
    if compliant ~= 1
        fprintf('Filter %i is not compliant', i);
    end
end