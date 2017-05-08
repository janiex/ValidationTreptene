clear all
clc


mm = 4;
mm1 = 0;
% 'Accelerations_param_damp_coeff_0.40_to_1.50_iterations_12_v=%u.txt'
NumberOfColumns = 12;
Results = zeros(7,NumberOfColumns);
for itt=1:NumberOfColumns
    %[fid,message1]=fopen([PathName FileName],'r');
    load_string = sprintf('q1pp_iso_param_speed_m=%u_%u',mm1,mm);
    mm = mm + 1;
    if(mm>9)
        mm = 0;
        mm1 = mm1+1;
    end
    %Results(:,itt) = load(load_string);
    Testo = load(load_string);
    
    Results(:,itt) = Testo.iso2631_rms';
end
x_value = [10 15 20 25 30 35 40];
pic = 1;
h = figure(pic);        
P = plot(x_value, Results(:,1),x_value, Results(:,2),x_value, Results(:,3),x_value, Results(:,4),x_value, Results(:,5),x_value, Results(:,6),x_value, Results(:,7),x_value, Results(:,8),x_value, Results(:,9),x_value, Results(:,10),x_value, Results(:,11),x_value, Results(:,12));
set(gca,'XTick',10:5:40);
grid on;

xlabel('Speed V in m/s','fontsize',9,'fontweight','b','color','black');
title('Ride quality factor by ISO 2631 at mass center (q1pp)','fontsize',9,'fontweight','b','color','black');
ylabel('RMS by ISO 2631','fontsize',9,'fontweight','b','color','black');

hleg1 = legend(P,'mm = 0.4','mm = 0.5','mm = 0.6','mm = 0.7','mm = 0.8','mm = 0.9','mm = 1.0','mm = 1.1','mm = 1.2','mm = 1.3','mm = 1.4','mm = 1.5', 'Location','NorthEastOutside');



uiwait(h);
