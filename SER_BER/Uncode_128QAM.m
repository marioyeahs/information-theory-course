% BER/SER for 128-QAM in AWGN
clc
clear all
close all

M = 128;                 % Modulation order
k = log2(M);            % Bits per symbol
EbNoVec = (5:15)';      % Eb/No values (dB)
numSymPerFrame = 16;   % Number of QAM symbols per frame

berEst = zeros(size(EbNoVec));
serEst = zeros(size(EbNoVec));

for n = 1:length(EbNoVec)
    % Convert Eb/No to SNR
    snrdB = EbNoVec(n) + 10*log10(k);
    % Reset the error counters
    numErrs = 0;
    numBits = 0;
    symErrs = 0;
    numSyms = 0;
         
    while numErrs < 200 && numBits < 1e7
        % Generate binary data and convert to symbols
        dataIn = randi([0 1],numSymPerFrame,k);
        dataSym = bi2de(dataIn);
        
        % QAM modulate using 'Gray' symbol mapping
        txSig = qammod(dataSym,M);
        
        % Pass through AWGN channel
        rxSig = awgn(txSig,snrdB,'measured');
        
        % Demodulate the noisy signal
        rxSym = qamdemod(rxSig,M);
        % Convert received symbols to bits
        dataOut = de2bi(rxSym,k);
        
        % Calculate the number of bit errors
        nErrors = biterr(dataIn,dataOut);
        
        % Calculate the number of symbol errors
        sErrors = symerr(dataIn,dataOut);
        
        % Increment the error and bit counters
        numErrs = numErrs + nErrors;
        numBits = numBits + numSymPerFrame*k;
        
        % Increment the error and symbol counters
        symErrs = symErrs + sErrors;
        numSyms = numSyms + numSymPerFrame*k;
        
    end
    
    % Estimate the BER
    berEst(n) = numErrs/numBits;
    
    % Estimate the SER
    serEst(n) = symErrs/numSyms;
end

[berTheory,serTheory] = berawgn(EbNoVec,'qam',M);

figure(1)
semilogy(EbNoVec,berEst,'*')
hold on
semilogy(EbNoVec,berTheory)
grid
legend('Estimated BER','Theoretical BER')
xlabel('Eb/No (dB)')
ylabel('Bit Error Rate')

figure(2)
semilogy(EbNoVec,serEst,'*')
hold on
semilogy(EbNoVec,serTheory)
grid
legend('Estimated SER','Theoretical SER')
xlabel('Eb/No (dB)')
ylabel('Symbol Error Rate')