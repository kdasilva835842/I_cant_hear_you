clc
clear
% f = 4000;
% c = 343;
% d = (c/4000)/2;
% %d=12*10^-3;
% tau = 0.5*d/c;
% theta = 0:0.01:2*pi;
% t0 = tau + (d/c)*cos(theta);
% phase = pi/2 -((0.5*2*pi*f)*t0);
% B = sqrt(2-2*cos(2*pi*f*t0));
% %H = B.*exp(1i*phase);
% 
% figure
% polarplot(theta,B)

f = 3340;
n = 4; %no of microphones
lambda = 343/f;
%d=lambda/2;
d=5*10^-2;
theta=0:(1/18)*pi:pi;
phaseDelay = -(2*pi*(d/lambda))*cos(theta);

weightTableAngles = zeros(length(phaseDelay),n);

%r=1;
for r=1:length(theta)
    for microphone=n:-1:1
       weightTableAngles(r,n+1-microphone)= phaseDelay(r)*(microphone-1);
    end
end
%%

weightTableAngles = conj(weightTableAngles);

%convert weight table in terms of imaginary numbers
A=1;
weightTableImag = zeros(length(phaseDelay),n);
for r=1:length(theta)
    for microphone=1:n
        weightTableImag(r,microphone)= A*(cos(weightTableAngles(r,microphone))+1i*sin(weightTableAngles(r,microphone)));
    end
end

%deltaT = (1/f)*(phaseDelay(5)/(2*pi))

%%
%Array formation

taper = weightTableImag(8,:);
microphone = phased.OmnidirectionalMicrophoneElement('FrequencyRange',[20 20e3],'BackBaffled',true);

array = phased.ULA(n,d,'Element',microphone,'ArrayAxis','x','Taper',conj(taper));
c = 343; %speed of sound

pos = getElementPosition(array);

figure;
viewArray(array,'ShowIndex','all','ShowTaper',true);

figure;
polarplot = plotResponse(array,f,c,'RespCut','Az','Format','Polar');
%%
% directivity = get(polarplot,'XData');
% angle=get(polarplot,'YData');
% 
% figure
% polarplot(angle,directivity)
angle=-180:1:180;
Ddata= directivity(array,f,angle,'PropagationSpeed',c);

figure
%plot(angle,Ddata);

D=zeros(1,181);
for i=1:181
    D(i)=Ddata(i+180);
end

angleRad=linspace(0,pi,181);

figure
%polar(angleRad,db2mag(D))
halfPolar(angleRad,D);

%##########################################################################
%######Simulating sounds and noise in different directions#################

samplingFreq = 8000;
duration = 3; %the file properties is showing duration of 5s
t=[0: 1/samplingFreq: duration];
y=sin(2*pi*3000*t)';
audiowrite('3kHzSine.wav',y,samplingFreq);
[y,samplingFreq]=audioread('3kHzSine.wav');


%sound(y,samplingFreq)

angleTone=[0;0];

fs=8000;
collector=phased.WidebandCollector('Sensor',array,'PropagationSpeed',c,...
    'SampleRate',fs,'NumSubbands',1000,'ModulatedInput',...
    false);

t_duration = 3;  % 3 seconds
t = 0:1/fs:t_duration-1/fs;

prevS = rng(2008); %to represent thermal noise of each microphone
noisePwr = 1e-4; % noise power

% preallocate
NSampPerFrame = 1000;
NTSample = t_duration*fs;
sigArray = zeros(NTSample,n);
tone = zeros(NTSample,1);

% set up audio device writer
audioWriter = audioDeviceWriter('SampleRate',fs, ...
        'SupportVariableSizeInput', true);
isAudioSupported = (length(getAudioDevices(audioWriter))>1);

toneFileReader = dsp.AudioFileReader('3kHzSine.wav',...
    'SamplesPerFrame',NSampPerFrame);

%simulate
%playOutput=zeros(length(tone),1);
for m = 1:NSampPerFrame:NTSample
    sig_idx = m:m+NSampPerFrame-1;
    x1 = toneFileReader();
    temp = collector([x1],...
        [angleTone]); %+ ...
        %sqrt(noisePwr)*randn(NSampPerFrame,n); %this adds the noise
       %%filter %%
    %playOutput = sum(temp,2);
    if isAudioSupported
        %play(audioWriter,0.5*temp(:,3));
        play(audioWriter,0.25*playOutput);
    end
    sigArray(sig_idx,:) = temp;
    tone(sig_idx) = x1;
end

outputData=sum(sigArray,2);

figure
plot(outputData/4)


% 
% ang_dft = [-30; 0]; %[azimuthAng; elevationAng]
% ang_cleanspeech = [-10; 10];
% ang_laughter = [90; 0];
% 
% fs = 8000;
% collector = phased.WidebandCollector('Sensor',array,'PropagationSpeed',c,...
%     'SampleRate',fs,'NumSubbands',1000,'ModulatedInput', false);
% 
% t_duration = 3;  % 3 seconds
% t = 0:1/fs:t_duration-1/fs;
% 
% prevS = rng(2008); %to represent thermal noise of each microphone
% noisePwr = 1e-4; % noise power
% 
% % preallocate
% NSampPerFrame = 1000;
% NTSample = t_duration*fs;
% sigArray = zeros(NTSample,n);
% voice_dft = zeros(NTSample,1);
% voice_cleanspeech = zeros(NTSample,1);
% voice_laugh = zeros(NTSample,1);
% 
% % set up audio device writer
% audioWriter = audioDeviceWriter('SampleRate',fs, ...
%         'SupportVariableSizeInput', true);
% isAudioSupported = (length(getAudioDevices(audioWriter))>1);
% 
% dftFileReader = dsp.AudioFileReader('dft_voice_8kHz.wav',...
%     'SamplesPerFrame',NSampPerFrame);
% speechFileReader = dsp.AudioFileReader('cleanspeech_voice_8kHz.wav',...
%     'SamplesPerFrame',NSampPerFrame);
% laughterFileReader = dsp.AudioFileReader('laughter_8kHz.wav',...
%     'SamplesPerFrame',NSampPerFrame);
% 
% % simulate
% for m = 1:NSampPerFrame:NTSample
%     sig_idx = m:m+NSampPerFrame-1;
%     x1 = dftFileReader();
%     x2 = speechFileReader();
%     x3 = 2*laughterFileReader();
%     temp = collector([x1 x2 x3],...
%         [ang_dft ang_cleanspeech ang_laughter]) + ...
%         sqrt(noisePwr)*randn(NSampPerFrame,n);
%     if isAudioSupported
%         play(audioWriter,0.5*temp(:,3));
%     end
%     sigArray(sig_idx,:) = temp;
%     voice_dft(sig_idx) = x1;
%     voice_cleanspeech(sig_idx) = x2;
%     voice_laugh(sig_idx) = x3;
% end


