
%% PHOTOVOLTAIC MODEL - FIGURES 11 TO 16
clear; clc; close all;

% Solar panel parameters
Isc=5.85; Voc=39.80; Rs=0.221; Rsh=415.405;
Ki=0.0032; Tn=298; n=1.3; Ego=1.1; Ns=54;
k=1.38e-23; q=1.6e-19; V=linspace(0,45,600);

% Operating conditions and blue tones
values={[400 600 800 1000],[15 25 45 70],[415.405 100 10 5]};
palette=[0 .20 .45;0 .35 .65;.25 .55 .80;.60 .78 .92];
styles={'-','--',':','-.'};
names={'irradiance','temperature','shunt resistance'};
units={'W/m^2','°C','\Omega'};
cond={'at 25 °C','at 1000 W/m²','at 25 °C and 1000 W/m²'};
folder='PV_Figures_PDF';
if ~exist(folder,'dir'), mkdir(folder); end

for a=1:3
    I=zeros(4,numel(V));
    for j=1:4
        G=1000; T=298; R=Rsh;
        if a==1, G=values{a}(j); end
        if a==2, T=values{a}(j)+273; end
        if a==3, R=values{a}(j); end

        % Photovoltaic model
        Iph=(Isc+Ki*(T-298))*G/1000;
        Irs=Isc/expm1(q*Voc/(n*k*Tn*Ns));
        Io=Irs*(T/Tn)^3*exp(q*Ego/(n*k)*(1/Tn-1/T));
        if a==2
            VocT=Voc-.23*(T-298);
            Io=(Iph-VocT/R)/expm1(q*VocT/(n*k*T*Ns));
        end

        % Newton-Raphson method
        x=Iph;
        for m=1:numel(V)
            for it=1:100
                z=q*(V(m)+x*Rs)/(n*k*T*Ns);
                e=exp(min(z,700));
                f=Iph-Io*(e-1)-(V(m)+x*Rs)/R-x;
                df=-Io*e*q*Rs/(n*k*T*Ns)-Rs/R-1;
                xn=x-f/df;
                if abs(xn-x)<1e-10, x=xn; break; end
                x=xn;
            end
            I(j,m)=max(x,0);
        end
    end

    % Generate I-V and P-V figures
    for b=1:2
        fig=9+2*a+b;
        h=figure(fig); clf(h); hold on; box on;
        set(h,'Color','w','Units','centimeters','Position',[3 3 17 12]);
        Y=I; tipo='I-V'; eje='Current (A)';
        if b==2, Y=I.*V; tipo='P-V'; eje='Power (W)'; end

        for j=1:4
            plot(V,Y(j,:),'Color',palette(j,:), ...
                'LineStyle',styles{j},'LineWidth',2);
        end

        labels=arrayfun(@(x)sprintf('%g %s',x,units{a}), ...
            values{a},'UniformOutput',false);

        xlabel('Voltage (V)'); ylabel(eje); xlim([0 45]);
        if b==1, ylim([0 7]); else, ylim([0 220]); end

        title(sprintf('Figure %d. Output %s curve with varying %s %s', ...
            fig,tipo,names{a},cond{a}),'FontSize',10);

        % Legend outside the plotting area
        lgd=legend(labels,'Location','southoutside', ...
            'Orientation','horizontal','NumColumns',4);
        lgd.Box='off'; lgd.FontSize=9;
        lgd.FontName='Times New Roman';

        % Grid and scientific formatting
        ax=gca; ax.FontName='Times New Roman'; ax.FontSize=10;
        ax.LineWidth=.9; ax.TickDir='out'; ax.XTick=0:5:45;
        if b==1, ax.YTick=0:1:7;
        else, ax.YTick=0:20:220; end
        grid on; grid minor;
        ax.GridColor=[.55 .58 .62]; ax.GridAlpha=.18;
        ax.MinorGridColor=[.65 .68 .72]; ax.MinorGridAlpha=.07;
        ax.MinorGridLineStyle=':';

        % Author name in upper-right corner
        text(.98,.96,'Jean David Cárdenas González', ...
            'Units','normalized','HorizontalAlignment','right', ...
            'VerticalAlignment','top','FontAngle','italic', ...
            'FontName','Times New Roman','FontSize',9);

        % Export to vector PDF
        drawnow;
        exportgraphics(h,fullfile(folder,sprintf('Figure_%d.pdf',fig)), ...
            'ContentType','vector','BackgroundColor','white');
        hold off;
    end
end
disp('Figures 11-16 exported successfully.'); 
