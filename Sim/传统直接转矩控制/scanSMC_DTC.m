clc; clear; close all;

model = 'SMC_DTC';
load_system(model);

Nref_range = 50:50:1000;

row = length(Nref_range);

n = 0;

t1 = tiledlayout(floor(sqrt(row))+1, floor(sqrt(row))+1);
set(gcf,'position',[0,0,40000,40000])
for Nref = Nref_range
    set_param([model '/Nref'], 'Value', num2str(Nref));

    simOut = sim(model);

    nexttile(t1)
    plot(simOut.Nr);
    ylabel(gca,''); 
    xlabel(gca,''); 
    title(['N ' num2str(Nref)]);
end
saveas(t1, 'plot/SMC_DTC_N.fig');
saveas(t1, 'plot/SMC_DTC_N.png');

t2 = tiledlayout(floor(sqrt(row))+1, floor(sqrt(row))+1);
set(gcf,'position',[0,0,4000,4000])
for Nref = Nref_range
    set_param([model '/Nref'], 'Value', num2str(Nref));

    simOut = sim(model);

    nexttile(t2)
    plot(simOut.alpha.Data, simOut.beta.Data);
    ylabel(gca,''); 
    xlabel(gca,''); 
    title(['N ' num2str(Nref)]);
    axis equal
        xlim([-0.6 0.6])
        ylim([-0.6 0.6])
end
saveas(t2, 'plot/SMC_DTC_F.fig');
saveas(t2, 'plot/SMC_DTC_F.png');

close_system(model, 0);