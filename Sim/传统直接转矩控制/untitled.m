clc; clear; close all;

model = 'DTC';
load_system(model);

Nref_range = 50:100:950;
flux_range = 0.1:0.1:1.5;

row = length(Nref_range);
col = length(flux_range);
n = 0;

t1 = tiledlayout(row,col);
set(gcf,'position',[0,0,40000,40000])
for Nref = Nref_range
    for flux = flux_range

        set_param([model '/Nref'], 'Value', num2str(Nref));
        set_param([model '/flux'], 'Value', num2str(flux));

        simOut = sim(model);

        nexttile(t1)
        plot(simOut.Nr);
        ylabel(gca,''); 
        xlabel(gca,''); 
        title(['N ' num2str(Nref) ', F ' num2str(flux)]);

    end
end
saveas(t1, 'plot/N.fig');

t2 = tiledlayout(row,col);
set(gcf,'position',[0,0,4000,4000])
for Nref = Nref_range
    for flux = flux_range

        set_param([model '/Nref'], 'Value', num2str(Nref));
        set_param([model '/flux'], 'Value', num2str(flux));

        simOut = sim(model);

        nexttile(t2)
        plot(simOut.alpha.Data, simOut.beta.Data);
        ylabel(gca,''); 
        xlabel(gca,''); 
        title(['N ' num2str(Nref) ', F ' num2str(flux)]);
        axis equal
        if(flux == flux_range(1))
            xlim([-flux_range(2) flux_range(2)])
            ylim([-flux_range(2) flux_range(2)])
        else
            xlim([-flux_range(col) flux_range(col)])
            ylim([-flux_range(col) flux_range(col)])
        end

    end
end
saveas(t2, 'plot/F.fig');

close_system(model, 0);