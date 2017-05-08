clear all
clc
% NumberOfResults = 6;
% ResultsOfSpeed = zeros(NumberOfResults);
% PathName = ['F:\MEI\Sozopol2012\Model\Original\Trep_Var_m\'];

speed = 10;
% 'Accelerations_param_damp_coeff_0.40_to_1.50_iterations_12_v=%u.txt'
Results = zeros(12,6);
for itt=1:6
    %[fid,message1]=fopen([PathName FileName],'r');
    load_string = sprintf('ISO_rms_%um_s',speed);
    speed = speed + 5;
    %Results(:,itt) = load(load_string);
    Testo = load(load_string);
    Results(:,itt) = Testo.iso2631_rms';
end
x_value = [0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5];
pic = 1;
h = figure(pic);        
P = plot(x_value, Results(:,1),x_value, Results(:,2),x_value, Results(:,3),x_value, Results(:,4),x_value, Results(:,5),x_value, Results(:,6));
set(gca,'XTick',0:0.1:1.5);
grid on;

xlabel('Damping coefficient m','fontsize',9,'fontweight','b','color','black');
title('Ride quality factor by ISO 2631 at mass center (q1pp)','fontsize',9,'fontweight','b','color','black');
ylabel('RMS by ISO 2631','fontsize',9,'fontweight','b','color','black');
%Legend_param = ['Speed = 10 m/s','Speed = 15 m/s','Speed = 20 m/s','Speed = 25 m/s','Speed = 30 m/s','Speed = 35 m/s','Speed = 40 m/s'];
hleg1 = legend(P,'Speed = 10 m/s','Speed = 15 m/s','Speed = 20 m/s','Speed = 25 m/s','Speed = 30 m/s','Speed = 35 m/s','Speed = 40 m/s', 'Location','NorthEastOutside');
%damper coefficient parametrization file is read


uiwait(h);
