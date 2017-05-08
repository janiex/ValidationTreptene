clear all
clc
q1pp_iso_param_speed0_4 = load('q1pp_iso_param_speed_m=0_4');
q1pp_iso_param_speed0_5 = load('q1pp_iso_param_speed_m=0_5');
q1pp_iso_param_speed0_6 = load('q1pp_iso_param_speed_m=0_6');
q1pp_iso_param_speed0_7 = load('q1pp_iso_param_speed_m=0_7');
q1pp_iso_param_speed0_8 = load('q1pp_iso_param_speed_m=0_8');
q1pp_iso_param_speed0_9 = load('q1pp_iso_param_speed_m=0_9');
q1pp_iso_param_speed1_0 = load('q1pp_iso_param_speed_m=1_0');
q1pp_iso_param_speed1_1 = load('q1pp_iso_param_speed_m=1_1');
q1pp_iso_param_speed1_2 = load('q1pp_iso_param_speed_m=1_2');
q1pp_iso_param_speed1_3 = load('q1pp_iso_param_speed_m=1_3');
q1pp_iso_param_speed1_4 = load('q1pp_iso_param_speed_m=1_4');
q1pp_iso_param_speed1_5 = load('q1pp_iso_param_speed_m=1_5');
z1 = q1pp_iso_param_speed0_4.iso2631_rms';
z2 = q1pp_iso_param_speed0_5.iso2631_rms';
z3 = q1pp_iso_param_speed0_6.iso2631_rms';
z4 = q1pp_iso_param_speed0_7.iso2631_rms';
z5 = q1pp_iso_param_speed0_8.iso2631_rms';
z6 = q1pp_iso_param_speed0_9.iso2631_rms';
z7 = q1pp_iso_param_speed1_0.iso2631_rms';
z8 = q1pp_iso_param_speed1_1.iso2631_rms';
z9 = q1pp_iso_param_speed1_2.iso2631_rms';
z10 = q1pp_iso_param_speed1_3.iso2631_rms';
z11 = q1pp_iso_param_speed1_4.iso2631_rms';
z12 = q1pp_iso_param_speed1_5.iso2631_rms';
% load the next
q1pp_iso_param_mm_10 = load('q1pp_ISO_rms_0_4_to_1_5_10m_s');
q1pp_iso_param_mm_15 = load('q1pp_ISO_rms_0_4_to_1_5_15m_s');
q1pp_iso_param_mm_20 = load('q1pp_ISO_rms_0_4_to_1_5_20m_s');
q1pp_iso_param_mm_25 = load('q1pp_ISO_rms_0_4_to_1_5_25m_s');
q1pp_iso_param_mm_30 = load('q1pp_ISO_rms_0_4_to_1_5_30m_s');
q1pp_iso_param_mm_35 = load('q1pp_ISO_rms_0_4_to_1_5_35m_s');
q1pp_iso_param_mm_40 = load('q1pp_ISO_rms_0_4_to_1_5_40m_s');
%speed
x_axis = [10:5:40]; 
y_axis = [0.4:0.1:1.5];
Z = [z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12];
[X,Y] = meshgrid(x_axis,y_axis);
X = X';
Y = Y';
surf(X,Y,Z);
colormap(jet);
%colormap('gray');
title('ISO 2631 RMS vibration','fontsize',9,'fontweight','b','color','black');
xlabel('Speed V in m/s [10-40]','fontsize',9,'fontweight','b','color','black');
ylabel('Damping coefficient[0.4-1.5]','fontsize',9,'fontweight','b','color','black');
zlabel('Ride Quality','fontsize',9,'fontweight','b','color','black');