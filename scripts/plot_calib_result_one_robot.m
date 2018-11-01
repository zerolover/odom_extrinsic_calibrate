close all;
clear all;
clc;


datasets_folder_path = '/home/pang/maplab_ws/src/maplab/algorithms/odom_extrinsic_calibrate/calibrate_dataset/evt_3_2_robot';

file_folder_list = dir(datasets_folder_path);

figure_cnt = 1;
for i =  1:numel(file_folder_list)
    nm = file_folder_list(i).name;
    if nm == '.' 
        continue;
    end
    
    
    full_name = [datasets_folder_path '/' nm];
    hold on;
    if isdir(full_name)
        full_name
        vio_odom = load([full_name '/vio_odom.txt']);
        original_integrate_odom = load([full_name '/original_integrate_odom.txt']);
        re_integrate_odom = load([full_name '/re_integrate_odom.txt']);
        optimize_integrate_odom = load([full_name '/optimize_re_integrate.txt']);
        
        encoder_meas = original_integrate_odom(:,4:5);
        
        data1 = vio_odom;
        data2 = original_integrate_odom;
        data3 = re_integrate_odom;
        data4 = optimize_integrate_odom;
        
        figure(figure_cnt);
        plot3(data1(:,1), data1(:,2), data1(:,3),'r');
        hold on;
        plot3(data2(:,1), data2(:,2), data2(:,3),'g');
        hold on;
%         plot3(data3(:,1), data3(:,2), data3(:,3),'b');
%         hold on;
        plot3(data4(:,1), data4(:,2), data4(:,3),'k');
        
        axis equal;
        title('trajecotries');
        xlabel('x');
        ylabel('y');
        legend('vio','uncalib','per-calib', 'conti-calib');
        view(0,90);
        
        figure_cnt = figure_cnt +1;

    end
    hold off;
    
end

%%
trans_error = load([datasets_folder_path '/trans_error_result.txt']);
calib_num =  size(trans_error,1);
figure(figure_cnt);

for i  = 1: calib_num
    plot(trans_error(i,:),'-s')
    hold on;
    legend_ar{i} = sprintf('calib = %d',i);
end

legend_ar{calib_num} = sprintf('un-calib');
legend(legend_ar,'Location','best');