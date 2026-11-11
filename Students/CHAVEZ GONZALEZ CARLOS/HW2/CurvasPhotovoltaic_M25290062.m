clear xlabel  ylabel  title;

prueba = [400, 600, 800, 1000];
prueba2 = [15, 25, 45, 70];
prueba3 = [5 10 100 415];
modelo = 'Photovoltaic_Model03.slx';


label = {'400 W/m^2', '600 W/m^2', '800 W/m^2', '1000 W/m^2'};
label2 = {'15°C', '25°C', '45°C', '70°C'};
label3 = {'5Ω', '10Ω', '100Ω', '415Ω'};

colors = {'k', ...      % Black
          'r', ...      % Red
          'b', ...      % Blue
          '#008080' ... % Teal Green
           };

figure(1);
hold on; grid on;
xlabel('Voltage (V)', 'FontName', 'Times New Roman', 'FontSize', 13); 
xlim([0 45]);
ylabel('Current (I)', 'FontName', 'Times New Roman', 'FontSize', 13); 
ylim([0 7]);
title('Figure 11. Output I–V curve with the varying irradiance at 25°C', ...
    'FontName', 'Times New Roman', 'FontSize', 13);
text(1, -0.08, 'Ing. Carlos E. Chavez González', ...
    'Units', 'normalized', ...
    'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'top');
grid minor;

figure(2);
hold on; grid on;
xlabel('Voltage (V)', 'FontName', 'Times New Roman', 'FontSize', 13); 
xlim([0 45]);
ylabel('Power (P)', 'FontName', 'Times New Roman', 'FontSize', 13);   
ylim([0 200]);
title('Figure 12. Output P-V curve with the varying irradiance at 25°C',...
    'FontName', 'Times New Roman', 'FontSize', 13);
text(1, -0.08, 'Ing. Carlos E. Chavez González', ...
    'Units', 'normalized', ...
    'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'top');
grid minor;


figure(3);
hold on; grid on;
xlabel('Voltage (V)', 'FontName', 'Times New Roman', 'FontSize', 13); 
xlim([0 45])
ylabel('Current (I)', 'FontName', 'Times New Roman', 'FontSize', 13); 
ylim([0 7]);
title('Figure 13. Output I-V curve with the varying temperature at 1000 W/m^2',...
    'FontName', 'Times New Roman', 'FontSize', 13);
grid minor;

figure(4);
hold on; grid on;
xlabel('Voltage (V)', 'FontName', 'Times New Roman', 'FontSize', 13); 
xlim([0 45]);
ylabel('Power (P)', 'FontName', 'Times New Roman', 'FontSize', 13);   
ylim([0 200]);
title('Figure 14. Output P-V curve with the varying temperature at 1000 W/m^2',...
    'FontName', 'Times New Roman', 'FontSize', 13);
text(1, -0.08, 'Ing. Carlos E. Chavez González', ...
    'Units', 'normalized', ...
    'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'top');
grid minor;

figure(5);
hold on; grid on;
xlabel('Voltage (V)', 'FontName', 'Times New Roman', 'FontSize', 13); 
xlim([0 45]);
ylabel('Current (I)', 'FontName', 'Times New Roman', 'FontSize', 13); 
ylim([0 7]);
title('Figure 15. Output I-V curve with the varying shunt resistance at 25°C and 1000 W/m^2',...
    'FontName', 'Times New Roman', 'FontSize', 13);
text(1, -0.08, 'Ing. Carlos E. Chavez González', ...
    'Units', 'normalized', ...
    'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'top');
grid minor;

figure(6);
hold on; grid on;
xlabel('Voltage (V)', 'FontName', 'Times New Roman', 'FontSize', 13); 
xlim([0 45]);
ylabel('Power (P)', 'FontName', 'Times New Roman', 'FontSize', 13);   
ylim([0 200]);
title('Figure 16. Output P-V curve with the varying shunt resistance at 25°C and 1000 W/m^2',...
    'FontName', 'Times New Roman', 'FontSize', 13);
text(1, -0.08, 'Ing. Carlos E. Chavez González', ...
    'Units', 'normalized', ...
    'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'top');
grid minor;

G = 1000;
T = 25;

for i = 1:4
    Rsh = prueba3 (i);

    out = sim('Photovoltaic_Model03.slx');

    voltage = out.voltage;
    current = out.current;
    power = out.power;

    figure(6);
    plot(voltage, power, '-', 'Color', colors{i}, 'LineWidth', 1.5);

    figure(5);
    plot(voltage, current, '-', 'Color', colors{i}, 'LineWidth', 1.5);
end

G = 1000;
Rsh = 415.405;

for i = 1:4
    T = prueba2 (i);

    out = sim('Photovoltaic_Model03.slx');

    voltage = out.voltage;
    current = out.current;
    power = out.power;

   
    figure(4);
    plot(voltage, power, '-', 'Color', colors{i}, 'LineWidth', 1.5);

    figure(3);
    plot(voltage, current, '-', 'Color', colors{i}, 'LineWidth', 1.5);
end

T = 25;
Rsh = 415.405;

for i = 1:4
    G = prueba (i);

    out = sim('Photovoltaic_Model03.slx');

    voltage = out.voltage;
    current = out.current;
    power = out.power;

    figure(2);
    plot(voltage, power, '-', 'Color', colors{i}, 'LineWidth', 1.5);

    figure(1);
    plot(voltage, current, '-', 'Color', colors{i}, 'LineWidth', 1.5);
end

figure(6) 
legend(label3, 'FontName', 'Times New Roman', 'FontSize', 12)

figure(5)
legend(label3, 'FontName', 'Times New Roman', 'FontSize', 12)

figure(4) 
legend(label2, 'FontName', 'Times New Roman', 'FontSize', 12)

figure(3); 
legend(label2, 'FontName', 'Times New Roman', 'FontSize', 12)

figure(2) 
legend(label, 'FontName', 'Times New Roman', 'FontSize', 12)

figure(1)
legend(label, 'FontName', 'Times New Roman', 'FontSize', 12)




    


