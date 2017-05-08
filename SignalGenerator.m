f_step = 0.1;                            % Input Signal Frequency
t=[0:1:10000];                         % Time Samples
    fs = 500;                          % Sampling Frequency
d = sin(2*pi*f_step/fs*t);               % Generate Sine Wave  
figure(1);
plot(t,x);
for f=f_step:0.1:0.2
    x = x + sin(2*pi*f/fs*t);               % Generate Sine Wave  

end
figure(2);
plot(t,x);
% stem(t,x,'r');                      % View the samples
% figure(2);
% stem(t*1/fs*1000,x,'r');            % View the samples
% hold on;
% plot(t*1/fs*1000,x);                % Plot Sine Wave