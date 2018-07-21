function y = filterBand33Function(x)
%FILTERBAND33FUNCTION Filters input x and returns output y.

% MATLAB Code
% Generated by MATLAB(R) 9.4 and DSP System Toolbox 9.6.
% Generated on: 18-Jul-2018 12:00:46

%#codegen

% To generate C/C++ code from this function use the codegen command. Type
% 'help codegen' for more information.

persistent Hd;

if isempty(Hd)
    
    % The following code was used to design the filter coefficients:
    % % Equiripple Bandpass filter designed using the FIRPM function.
    %
    % % All frequency values are in Hz.
    % Fs = 40000;  % Sampling Frequency
    %
    % Fstop1 = 1600;            % First Stopband Frequency
    % Fpass1 = 1780;            % First Passband Frequency
    % Fpass2 = 2240;            % Second Passband Frequency
    % Fstop2 = 2500;            % Second Stopband Frequency
    % Dstop1 = 0.001;           % First Stopband Attenuation
    % Dpass  = 0.057501127785;  % Passband Ripple
    % Dstop2 = 0.001;           % Second Stopband Attenuation
    % dens   = 20;              % Density Factor
    %
    % % Calculate the order from the parameters using FIRPMORD.
    % [N, Fo, Ao, W] = firpmord([Fstop1 Fpass1 Fpass2 Fstop2]/(Fs/2), [0 1 ...
    %                           0], [Dstop1 Dpass Dstop2]);
    %
    % % Calculate the coefficients using the FIRPM function.
    % b  = firpm(N, Fo, Ao, W, {dens});
    
    Hd = dsp.FIRFilter( ...
        'Numerator', [9.99347209016013e-05 0.000740943985349504 ...
        0.000235783642368832 0.000318537960871185 0.000277165873429306 ...
        0.000207288627047223 9.66403207743333e-05 -4.56408868222078e-05 ...
        -0.000207499824788275 -0.000371907221832323 -0.000519120191946537 ...
        -0.000628454075777416 -0.000681156354177906 -0.000662721113725093 ...
        -0.000565688791603545 -0.000391063591243114 -0.000149642272245937 ...
        0.000138611028411246 0.000445625702869264 0.000738131015482678 ...
        0.000980824544988327 0.00114074187815203 0.00119107211372128 ...
        0.00111530181238985 0.000909804879284045 0.000585815465107854 ...
        0.000169075862870415 -0.000301606496881337 -0.000778265472243336 ...
        -0.00120833374497206 -0.00154073355757818 -0.00173162031008661 ...
        -0.00175013888109946 -0.00158260391327728 -0.00123548769761873 ...
        -0.000735715131923384 -0.000129084201396321 0.000524285713702282 ...
        0.00115578638495584 0.00169609586305103 0.00208242181905448 ...
        0.00226632307156187 0.00221942677369578 0.00193808264417352 ...
        0.0014443186316037 0.000784435169349926 2.40322485242435e-05 ...
        -0.000758213214350317 -0.00147905962169506 -0.00205981909827715 ...
        -0.00243613475245885 -0.00256500948957378 -0.00242979844501786 ...
        -0.00204226478243679 -0.00144275962653491 -0.000695069408354519 ...
        0.000121127437083715 0.000918598225767527 0.00161167824610018 ...
        0.0021278190624589 0.00241491141495198 0.00244617776039674 ...
        0.00222457858002383 0.00178174971132152 0.0011719778751239 ...
        0.000468487981911254 -0.000248054295553432 -0.000898861845567227 ...
        -0.00141449246184649 -0.00174653211338979 -0.00186853349146496 ...
        -0.00178245795708592 -0.00151404044872928 -0.00111085663050288 ...
        -0.000633760629976137 -0.000149131907208117 0.000280578854548273 ...
        0.000605214258808761 0.000793193830673587 0.000835465864178133 ...
        0.000745618380668534 0.000557260762866617 0.000318037891676179 ...
        8.21303208338479e-05 -9.88560423279443e-05 -0.000184073073368252 ...
        -0.000150649561731696 2.36350551520122e-06 0.000252741866011377 ...
        0.00055797956378772 0.000860724528621101 0.00109756390314377 ...
        0.00120861046399021 0.00114770604199719 0.000890581341314682 ...
        0.000440942482327649 -0.000167682368798318 -0.000873558088856574 ...
        -0.00159340831973577 -0.00223186166284844 -0.00269394127300476 ...
        -0.0028975173158614 -0.00278605016128046 -0.00233791123323767 ...
        -0.00157235157575682 -0.000549809648633388 0.000632287393079431 ...
        0.00184928862134741 0.00296297803860186 0.00383789339606579 ...
        0.00435771351058596 0.00444071309473282 0.0040514779926867 ...
        0.00320750073645095 0.00197925224061381 0.000484744324272547 ...
        -0.00112289746502915 -0.00267198076364114 -0.00399157409161485 ...
        -0.00493133832933705 -0.00537998841503634 -0.00527858718470042 ...
        -0.00462871260044856 -0.0034933831449528 -0.00199045322982099 ...
        -0.00027959243347588 0.00145538012357018 0.00302838509452536 ...
        0.0042719332341983 0.0050568402292473 0.0053070911146588 ...
        0.00500785023832451 0.00420690120975709 0.00300779536275213 ...
        0.00155636388171241 2.28854948303673e-05 -0.00141988079161625 ...
        -0.00261666663063197 -0.00344943327807 -0.00384958959054356 ...
        -0.00380591175709977 -0.00336277017324047 -0.00261273040061947 ...
        -0.00168171021910355 -0.000710815311775414 0.000164310216963069 ...
        0.000832366859979047 0.00122203497542757 0.00131117620930059 ...
        0.00112917245040372 0.000751228480823332 0.000286020890499994 ...
        -0.000142399521914469 -0.000414975473585621 -0.00043827294439107 ...
        -0.000161724035471011 0.000410807734708646 0.00121762148604302 ...
        0.00214416314700743 0.00303676391366917 0.0037232125380307 ...
        0.00403807893108553 0.00384890231406052 0.00308015391166269 ...
        0.00173103708723455 -0.000115590675732201 -0.00229527172154736 ...
        -0.00457538201849484 -0.00667889490614227 -0.00831663078747156 ...
        -0.00922372385932861 -0.00919626086452615 -0.00812330201959042 ...
        -0.00600981954858312 -0.00298696448930612 0.000692685925866796 ...
        0.00467473543774797 0.00853729535844732 0.0118352451198984 ...
        0.0141509621627635 0.0151452193551565 0.0146023654364499 ...
        0.0124637641691185 0.00884534851377395 0.00403578197761824 ...
        -0.00152530071228133 -0.00728759795046994 -0.0126452516391731 ...
        -0.0170015449985291 -0.0198353540204849 -0.0207629977810142 ...
        -0.0195871994750395 -0.016327645455701 -0.0112289225892062 ...
        -0.00474357553104042 0.00250835745735779 0.009799712599788 ...
        0.0163709201977562 0.0215104758362607 0.0246334428713945 ...
        0.0253481097395298 0.0235042114558695 0.0192160526459615 ...
        0.0128576942163947 0.00503026272001289 -0.0034966977050747 ...
        -0.0118624272010011 -0.0192044865095965 -0.0247496061932267 ...
        -0.0278972027721932 -0.0282853895010597 -0.0258330400148666 ...
        -0.0207521788393336 -0.0135294702015033 -0.00487833992850323 ...
        0.00433350052039531 0.013173604515077 0.0207417647026867 ...
        0.0262642035220296 0.0291748226844579 0.0291748226844579 ...
        0.0262642035220296 0.0207417647026867 0.013173604515077 ...
        0.00433350052039531 -0.00487833992850323 -0.0135294702015033 ...
        -0.0207521788393336 -0.0258330400148666 -0.0282853895010597 ...
        -0.0278972027721932 -0.0247496061932267 -0.0192044865095965 ...
        -0.0118624272010011 -0.0034966977050747 0.00503026272001289 ...
        0.0128576942163947 0.0192160526459615 0.0235042114558695 ...
        0.0253481097395298 0.0246334428713945 0.0215104758362607 ...
        0.0163709201977562 0.009799712599788 0.00250835745735779 ...
        -0.00474357553104042 -0.0112289225892062 -0.016327645455701 ...
        -0.0195871994750395 -0.0207629977810142 -0.0198353540204849 ...
        -0.0170015449985291 -0.0126452516391731 -0.00728759795046994 ...
        -0.00152530071228133 0.00403578197761824 0.00884534851377395 ...
        0.0124637641691185 0.0146023654364499 0.0151452193551565 ...
        0.0141509621627635 0.0118352451198984 0.00853729535844732 ...
        0.00467473543774797 0.000692685925866796 -0.00298696448930612 ...
        -0.00600981954858312 -0.00812330201959042 -0.00919626086452615 ...
        -0.00922372385932861 -0.00831663078747156 -0.00667889490614227 ...
        -0.00457538201849484 -0.00229527172154736 -0.000115590675732201 ...
        0.00173103708723455 0.00308015391166269 0.00384890231406052 ...
        0.00403807893108553 0.0037232125380307 0.00303676391366917 ...
        0.00214416314700743 0.00121762148604302 0.000410807734708646 ...
        -0.000161724035471011 -0.00043827294439107 -0.000414975473585621 ...
        -0.000142399521914469 0.000286020890499994 0.000751228480823332 ...
        0.00112917245040372 0.00131117620930059 0.00122203497542757 ...
        0.000832366859979047 0.000164310216963069 -0.000710815311775414 ...
        -0.00168171021910355 -0.00261273040061947 -0.00336277017324047 ...
        -0.00380591175709977 -0.00384958959054356 -0.00344943327807 ...
        -0.00261666663063197 -0.00141988079161625 2.28854948303673e-05 ...
        0.00155636388171241 0.00300779536275213 0.00420690120975709 ...
        0.00500785023832451 0.0053070911146588 0.0050568402292473 ...
        0.0042719332341983 0.00302838509452536 0.00145538012357018 ...
        -0.00027959243347588 -0.00199045322982099 -0.0034933831449528 ...
        -0.00462871260044856 -0.00527858718470042 -0.00537998841503634 ...
        -0.00493133832933705 -0.00399157409161485 -0.00267198076364114 ...
        -0.00112289746502915 0.000484744324272547 0.00197925224061381 ...
        0.00320750073645095 0.0040514779926867 0.00444071309473282 ...
        0.00435771351058596 0.00383789339606579 0.00296297803860186 ...
        0.00184928862134741 0.000632287393079431 -0.000549809648633388 ...
        -0.00157235157575682 -0.00233791123323767 -0.00278605016128046 ...
        -0.0028975173158614 -0.00269394127300476 -0.00223186166284844 ...
        -0.00159340831973577 -0.000873558088856574 -0.000167682368798318 ...
        0.000440942482327649 0.000890581341314682 0.00114770604199719 ...
        0.00120861046399021 0.00109756390314377 0.000860724528621101 ...
        0.00055797956378772 0.000252741866011377 2.36350551520122e-06 ...
        -0.000150649561731696 -0.000184073073368252 -9.88560423279443e-05 ...
        8.21303208338479e-05 0.000318037891676179 0.000557260762866617 ...
        0.000745618380668534 0.000835465864178133 0.000793193830673587 ...
        0.000605214258808761 0.000280578854548273 -0.000149131907208117 ...
        -0.000633760629976137 -0.00111085663050288 -0.00151404044872928 ...
        -0.00178245795708592 -0.00186853349146496 -0.00174653211338979 ...
        -0.00141449246184649 -0.000898861845567227 -0.000248054295553432 ...
        0.000468487981911254 0.0011719778751239 0.00178174971132152 ...
        0.00222457858002383 0.00244617776039674 0.00241491141495198 ...
        0.0021278190624589 0.00161167824610018 0.000918598225767527 ...
        0.000121127437083715 -0.000695069408354519 -0.00144275962653491 ...
        -0.00204226478243679 -0.00242979844501786 -0.00256500948957378 ...
        -0.00243613475245885 -0.00205981909827715 -0.00147905962169506 ...
        -0.000758213214350317 2.40322485242435e-05 0.000784435169349926 ...
        0.0014443186316037 0.00193808264417352 0.00221942677369578 ...
        0.00226632307156187 0.00208242181905448 0.00169609586305103 ...
        0.00115578638495584 0.000524285713702282 -0.000129084201396321 ...
        -0.000735715131923384 -0.00123548769761873 -0.00158260391327728 ...
        -0.00175013888109946 -0.00173162031008661 -0.00154073355757818 ...
        -0.00120833374497206 -0.000778265472243336 -0.000301606496881337 ...
        0.000169075862870415 0.000585815465107854 0.000909804879284045 ...
        0.00111530181238985 0.00119107211372128 0.00114074187815203 ...
        0.000980824544988327 0.000738131015482678 0.000445625702869264 ...
        0.000138611028411246 -0.000149642272245937 -0.000391063591243114 ...
        -0.000565688791603545 -0.000662721113725093 -0.000681156354177906 ...
        -0.000628454075777416 -0.000519120191946537 -0.000371907221832323 ...
        -0.000207499824788275 -4.56408868222078e-05 9.66403207743333e-05 ...
        0.000207288627047223 0.000277165873429306 0.000318537960871185 ...
        0.000235783642368832 0.000740943985349504 9.99347209016013e-05]);
end

y = step(Hd,double(x));


% [EOF]
