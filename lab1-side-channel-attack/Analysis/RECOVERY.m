%% Key Recovery

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Differential Power Analys is Template  %
% Authors: Filip Stepanek and Jiri Bucek %
% Modified by: Oskar Naslund, 2020-03-03 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all, close all, clc

% 'tables.mat' contains 'subBytes' and 'byteHammingWeight'
% these can now be found in the workspace TRY PRINTING THEM
% in the command window by writing their variable names
load("tables.mat")

% below are the arguments to the function 'myload()' modify
% 'segmentLength' and 'offset' to crop the loaded trace segment
% use the arguments that apply for the key that is to be recovered
% and comment out the rest

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 'myload()' argument values for the known key trace %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
traceSize = 370000;
offset = 0;
segmentLength = 370000;
numberOfTraces = 200;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 'myload()' argument values for the unknown key trace %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%traceSize = 550000;
%offset = 0;
%segmentLength = 550000;
%numberOfTraces = 150;

% below are the arguments to the function 'myin()'
% these are the same for both trace types, and should not be changed
columns = 16;
rows = numberOfTraces;

% 'myload()' processes the binary file containing the measured traces and
% stores the data in the output matrix so the trace segments
% can be used for the key recovery process.
% Inputs:
%   '"file"' - name of the file containing the measured traces
%   'traceSize' - number of samples in each trace
%   'offset' - used to define different beginning of the power trace
%   'segmentLength' - used to define different/reduced length of the power trace
%   'numberOfTraces' - number of traces to be loaded

% use the appropriate trace
traces = myload("traces-00112233445566778899aabbccddeeff.bin", traceSize, offset, segmentLength, numberOfTraces);
%traces = myload("traces-unknown_key.bin", traceSize, offset, segmentLength, numberOfTraces);

% 'myin()' is used to load the plaintext and ciphertext 
% to the corresponding matrices. 
% Inputs:
%   '"file"' - name of the file containing the plaintext or ciphertext
%   'columns' - number of columns (e.g., size of the AES data block)
%   'rows' - number of rows (e.g., number of measurements)

% use the appropriate plain- and ciphertext
plaintext = myin("plaintext-00112233445566778899aabbccddeeff.txt", columns, rows);
ciphertext = myin("ciphertext-00112233445566778899aabbccddeeff.txt", columns, rows);
%plaintext = myin("plaintext-unknown_key.txt", columns, rows);
%ciphertext = myin("ciphertext-unknown_key.txt", columns, rows);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TASK 1. plot the power trace(s) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1.1. plot one trace or plot the mean value of all traces
% 1.2. try and identify the rounds of AES, and modify the myload arguments
%      to load only the segment corresponding to the first round of AES
% 1.3. read about how the AES versions are different from oneanother and
%      figure out which version of AES was used from the number of rounds
% 1.4. plot one trace segment or plot the mean value of all trace segments
%      and keep these argument settings for the key recovery

% --> create the plots here <--


%%%%%%%%%%%%%%%%%%%%%%%%
% TASK 2. key recovery %
%%%%%%%%%%%%%%%%%%%%%%%%
% 2.1. create the power hypothesis for each byte of the key
% 2.2. investigate how the power hypothesis correlates with the
%      measured power consumption loaded into the variable 'traces'
%      this should be done using the function 'mycorr()'
% 2.3. figure out what 'CC' is, and use the variable to recover the key

% variables declaration
byteStart = 1;
byteEnd = 16;
keyCandidateStart = 0;
keyCandidateStop = 255;

% for every byte in the key do:
for BYTE=byteStart:byteEnd
    
    % create the power hypothesis matrix with dimensions
    % number of rows = numberOfTraces and number of columns = 256
    % the number 256 represents all possible bytes (e.g., 0x00..0xFF)
    powerHypothesis = zeros(numberOfTraces,256);
    for K = keyCandidateStart:keyCandidateStop
        
        % --> create the power hypothesis here <--
        
        
    end;

    % 'mycorr()' returns the correlation coeficients matrix calculated
    % from the power consumption hypothesis matrix powerHypothesis and
    % the measured power traces
    CC = mycorr(powerHypothesis, traces);
    
    % --> find the correct key byte here <--

    
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TASK 3. post recovery analysis %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3.1. confirm that you found the correct key by using an online AES tool
%      http://extranet.cryptomathic.com/aescalc/index
%      enter the provided plaintext and the recovered key and compare the 
%      calculated ciphertext with the provided ciphertext
% 3.2. read about block cipher mode of operation
%      https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation
%      and figure out which mode was used for the encryption in this lab
% 3.3. explore how the 'myload()' function argument 'numberOfTraces'
%      affects the key recovery process by changing its value
% 3.4. if 'numberOfTraces' affects the key recovery process,
%      figure out why and how it plays a role
