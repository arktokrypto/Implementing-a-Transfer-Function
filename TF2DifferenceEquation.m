% TF to Difference equation v2.0
% This is a code to convert s-domain second order trasfer functions to z transform which will in turn be converted to difference equations.
% The outputs of s-transform, z transform, and difference equation will be compared to validate the final difference equation
% Sine wave input is used for comparison.
% Copy simulink file imple.slx along with this code



% Default plot settings
set(groot,'defaultAxesXGrid','on')
set(groot,'defaultAxesYGrid','on')
set(0,'DefaultLineLineWidth',1.5)
set(0,'DefaultAxesFontName','cambria math');set(0,'DefaultTextFontName','cambria math')
set(0,'DefaultlineMarkerSize',4);
set(0,'DefaultlineMarkerFace','k')
set(0, 'DefaultAxesFontSize', 14);set(0, 'DefaultTextFontSize', 14);
set(0,'DefaultFigureColor','w', 'DefaultAxesColor','w','DefaultAxesXColor','k', 'DefaultAxesYColor','k',...
 'DefaultAxesZColor','k','DefaultTextColor','k')


clc
clear all
s=tf('s');
fsin=1; % Input sine wave frequency to compare the response of continuous and discrete systems.
Gc= (0.9481*s^2 + 4.452*s + 1.989)/(s^2 + 6.107*s + 0.8814); %Compensator transfer function Without
%fins

% Extract the coefficients of continuous transfer function. For the
% simulink model.
[num,den]=tfdata(Gc,'v');
anc=num(1);
bnc=num(2);
cnc=num(3);
adc=den(1);
bdc=den(2);
cdc=den(3);


% Convert Continuous TF to discrete TF using bilinear, ZOH, or FOH. Change
% it from c2d matlab function.
Gcz=c2d(Gc,1/100,'tustin');
[num,den]=tfdata(Gcz,'v');
% Extract coefficients of dicrete trasnfer function
an=num(1);
bn=num(2);
cn=num(3);
ad=den(1);
bd=den(2);
cd=den(3);



% Check the difference equation output for different inputs
t=0:1/100:100;
Cout=0;
for k=1:1:numel(t)
cin(k)=sin(2*pi*fsin*t(k)); % Change the inputs form here
if k<3
cout(k)=0; % Since the difference equation need to previous outputs, first two outputs are set to zero.
end
if k>2
cout(k)=(1/ad)*(an*cin(k)+bn*cin(k-1)+cn*cin(k-2)-bd*cout(k-1)-cd*cout(k-2)); % Difference equation. Derived using pen and paper
end
end



figure(1)
step(Gcz)
hold on
step(Gc)
legend('Discrete','Continuous')
grid on

figure(2)
plot(t,cout) % Output of difference equation
hold on
plot(t,cin) % Input
xlabel('Time(s)')
legend('Output','Input')

