% Author: Marta Szukalska 24.08.2016 
%The function below performs the windowed autocorrelation of the input signal. 

function Autokorelacja(audiofile)

[x,Fs] = audioread(audiofile); % Reads in the audiofile with its sampling rate.

x=x(:).'; %Swap the columns with rows.


windowSize = 8000; %Length of the autocorrelation window.
hopSize = 1000; %The hop size between two consecutive overlaping windows. 
start = 0; % The start point of the window.
endPoint = windowSize; % The end point of the window.

h = ceil(length(x)/hopSize); % h is the rounded number of frames for a given signal.
g = h*hopSize; % g is the expected length of the signal for number h of frames.
x = [x , zeros(1, (g-length(x))+windowSize)];%The signal x is zeropadded.
sum = zeros(h, windowSize); %Create the matrix to keep the autocorrelation results 
                            %for every frame.
% The for loops itterate through every frame calculating their autocorrelations 
%and save the result in a matrix sum. 
for k=0:h-1
    
    for i = 0 : windowSize-1
    
        y2 = [zeros(1, i) , x(start+1:endPoint)]; % The signal x is zeropadded 
                                                  % to delay it.
        y1 = [x(start+1:endPoint), zeros(1, i)]; %The signal x is zeropadded 
                                                 %to match it to the length
                                                 %of its delayed version.
    
        for n=0: windowSize+i-1
            sum(k+1,i+1) = sum(k+1,i+1) + (y1(n+1)*y2(n+1)); % Calculate the autocorrelation.
        end
        
    end
    start = start + hopSize; %Add the hop size to the current start point,
                             %to get the start point of the next frame.
    endPoint = endPoint + hopSize; %Update the endpoint to get the one for
                                    % the following frame.
end
end