%% List of essential information
rat = 'kontrola15';
path = ['D:\Szczury\',rat,'\'];
veps = [1,5,9,13];
struction = 'CxC';
chans = [1,4,8,10];

%more detials
N = 1000; %number of repetitions 
n_set = 300; %number of trials

sack = zeros(length(chans),length(veps)*n_set); %contains aplitudes of single trials for each channel
amplitude = zeros(300,1); %temporal variable

%% Loading data and counting amplitudes between 0 - 0.1 s
for v=1:length(veps)
    load([path, rat,'_VEP',num2str(veps(v)),'.mat'])
    for c = 1:length(chans)
        for training = 1:n_set
            %amplitude is an absolute value in a choosen time band
            amplitude(training) = abs(max(all_dataTrial(chans(c), 51:75, training)))+abs(min(all_dataTrial(chans(c), 51:75, training)));
        end
        sack(c, (n_set*(v-1))+1:n_set*v) = amplitude;
    end
end
clearvars -except rat path veps struction chans sack N n_set
%% The statistic starts here
t_values = zeros(length(chans), N);
t_real = zeros(length(chans), 3);
for c = 1:length(chans)
    %disp(['Channel ', struction, num2str(chans(c))]);
    for v=1:3
        %Real data
        control = [mean(sack(c,1:300)), std(sack(c,1:300))];
        training = [mean(sack(c,v*300+1:(v+1)*300)), std(sack(c,v*300+1:(v+1)*300))];
        t_real(c,v) = (training(1)-control(1))/sqrt((control(2)^2+training(2)^2)/n_set);
        %Bootstrap data
        control_prim = zeros(N, 2);
        training_prim = zeros(N, 2);
        for s = 1:N
            a = randi(1200,300,1);
            b = randi(1200,300,1);
            control_prim(s, 1) = mean(sack(c, a));
            control_prim(s, 2) = std(sack(c,a));
            training_prim(s, 1) = mean(sack(c, b));
            training_prim(s, 2) = std(sack(c,b));
        end
        
        for i = 1:N
            t_values(c,i) = (training_prim(i,1) - control_prim(i,1))/sqrt((training_prim(i,2).^2+control_prim(i,2).^2)/N);
        end
    end
end
clearvars -except rat path veps struction chans N n_set t_values t_real
% for i =1:1
%     fig=figure;
%     hax=axes;
%     y = tpdf(sort(t_values(i,:)), 2*n_set-2);
%     subplot(1, 1, i)
%     plot(y)
%     hold on
%     t = prctile(t_values(i,:), [2.5 97.5]);
%     line([25 25],get(hax,'YLim'),'Color',[1 0 0])
% end

for j=1:4
    figure()
    for i=1:3
        subplot(3,1,i)
        V = sort(t_values(j,:));
        y = tpdf(V, 2*n_set-2);
        
        suma_max = 0;
        suma_min = 0;
        ind_max = N;
        ind_min = 1;
        while suma_max < 4.8577
            suma_max = suma_max + y(ind_max);
            ind_max = ind_max - 1;
        end
        while suma_min < 4.8577
            suma_min = suma_min + y(ind_min);
            ind_min = ind_min + 1;
        end
        
        plot(V,y,'k')
        xlim([-6.5 6.5])
        hold on
        h(1) = area(V(V>V(ind_max+1)), y(V>V(ind_max+1)));
        h(1).FaceColor = [1 0.9 1];
        h(2) = area(V(V<V(ind_min-1)), y(V<V(ind_min-1)));
        h(2).FaceColor = [1 0.9 1];
        hold on
        if t_real(j,i)>min(t_values(j,:)) && t_real(j,i)<max(t_values(j,:))
            line([t_real(j,i) t_real(j,i)],[0 0.2], 'color', [0.8 0 0])
        else
            if t_real(j,i)>0
                line([V(N) V(N)],[0 0.2], 'color', [0.8 0 0])
            else
                line([V(1) V(1)],[0 0.2], 'color', [0.8 0 0])
            end
        
        end
    end
end
% disp(['Control vs ', ' after ', num2str(v), 'h']);
% disp(prctile(t_values, [2.5 97.5]));
% disp(t_real)
% p_value = (sum(y(1:25))+sum(y(976:1000)))/sum(y);
% disp(['p_value: ', num2str(p_value)])


