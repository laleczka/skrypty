%% List of essential information
rat = 'kontrola15';
path = ['C:\Users\L635-10K\Desktop\lic_fiz\dane\',rat,'\'];
veps = [1,5,9,13];
struction = 'CxC';
chans = [1,4,8,10];

%more detials
N = 1000; %number of repetitions 
n_set = 300; %number of trials

sack = zeros(length(chans),length(veps)*n_set,25); %contains aplitudes of single trials for each channel
tmp = zeros(n_set,25); %temporal variable

%% Loading data and counting amplitudes between 0 - 0.1 s
for v=1:length(veps)
    load([path, rat,'_VEP',num2str(veps(v)),'.mat'])
    for c = 1:length(chans)
        for trial = 1:n_set
            %amplitude is an absolute value in a choosen time band
            tmp(trial,:) = all_dataTrial(chans(c), 51:75, trial);
        end
        sack(c, (n_set*(v-1))+1:n_set*v, :) = tmp;
    end
end
%abs(max(all_dataTrial(chans(c), 51:75, trial)))+abs(min(all_dataTrial(chans(c), 51:75, trial))
clearvars -except rat path veps struction chans sack N n_set
%% Real amplitudes
t_real = zeros(length(chans), length(veps));
for c = 1:length(chans)
    for v = 1:3
        contr = max(mean(sack(c,1:300,:), 2)) - min(mean(sack(c,1:300,:), 2));
        train = max(mean(sack(c,v*300+1:(v+1)*300,:), 2)) - min(mean(sack(c,v*300+1:(v+1)*300,:), 2));
        t_real(c,v) = train-contr;
    end
end
%% Bootstrap amplitudes   
t_values = zeros(length(chans),length(veps),N);
tmp_boot = zeros(length(veps), N);
for c = 1:length(chans)
    for v = 1:length(veps)
        for n=1:N
            ind_a = randi(1200,300,1);
            ind_b = randi(1200,300,1);
            cont_boot = max(mean(sack(c,ind_a,:), 2)) - min(mean(sack(c,ind_a,:), 2));
            train_boot = max(mean(sack(c,ind_b,:), 2)) - min(mean(sack(c,ind_b,:), 2));
            tmp_boot(v,n) = train_boot - cont_boot;
        end
    end
    t_values(c,:,:) = tmp_boot;
end
%%
for v=1:1
    disp(['Kana³ 1, kontrola vs po ', num2str(v), ' godzinie']);
    disp(['Zbiór wartoœci: ', num2str(prctile(squeeze(t_values(1,v,:)), [2.5 97.5]))]);
    disp(['Wartoœæ statystyki: ', num2str(t_real(1,v))]);
    disp(['Percentyl: ', num2str(invprctile(squeeze(t_values(1,v,:)), t_real(1,v)))]);
end

V = sort(squeeze(t_values(1,1,:)));
a = find(V<t_real(1,1));
prc = length(a)/N;


%% The statistic starts here
% t_values = zeros(length(chans), N);
% t_real = zeros(length(chans), 3);
% for c = 1:length(chans)
%     %disp(['Channel ', struction, num2str(chans(c))]);
%     for v=1:3
%         %Real data
%         control = [mean(sack(c,1:300)), std(sack(c,1:300))];
%         trial = [mean(sack(c,v*300+1:(v+1)*300)), std(sack(c,v*300+1:(v+1)*300))];
%         t_real(c,v) = (trial(1)-control(1))/sqrt((control(2)^2+trial(2)^2)/n_set);
%         %Bootstrap data
%         control_prim = zeros(N, 2);
%         training_prim = zeros(N, 2);
%         for s = 1:N
%             a = randi(1200,300,1);
%             b = randi(1200,300,1);
%             control_prim(s, 1) = mean(sack(c, a));
%             control_prim(s, 2) = std(sack(c,a));
%             training_prim(s, 1) = mean(sack(c, b));
%             training_prim(s, 2) = std(sack(c,b));
%         end
%         
%         for i = 1:N
%             t_values(c,i) = (training_prim(i,1) - control_prim(i,1))/sqrt((training_prim(i,2).^2+control_prim(i,2).^2)/N);
%         end
%     end
% end
% limit_min = abs(min(min(t_values(:,:),[],2)));
% limit_max = max(max(t_values(:,:),[],2));
% limit = max(limit_min, limit_max);
% 
% clearvars -except rat path veps struction chans N n_set t_values t_real limit
% for j=1:4
%     figure()
%     for i=1:3
%         subplot(3,1,i)
%         V = sort(t_values(j,:));
%         y = tpdf(V, 2*n_set-2);
%         
%         suma_max = 0;
%         suma_min = 0;
%         ind_max = N;
%         ind_min = 1;
%         while suma_max < sum(y)*0.025
%             suma_max = suma_max + y(ind_max);
%             ind_max = ind_max - 1;
%         end
%         while suma_min < sum(y)*0.025
%             suma_min = suma_min + y(ind_min);
%             ind_min = ind_min + 1;
%         end
%         
%         plot(V,y,'k')
%         xlim([-1.1*limit 1.1*limit])
%         hold on
%         h(1) = area(V(V>V(ind_max+1)), y(V>V(ind_max+1)));
%         set(h(1),'FaceColor',[1 1 0])
%         %h(1).FaceColor = [1 0.9 1];
%         h(2) = area(V(V<V(ind_min-1)), y(V<V(ind_min-1)));
%         set(h(2),'FaceColor',[1 1 0])
%         %h(2).FaceColor = [1 0.9 1];
%         hold on
%         if t_real(j,i)>min(t_values(j,:)) && t_real(j,i)<max(t_values(j,:))
%             line([t_real(j,i) t_real(j,i)],[0 0.2], 'color', [0.8 0 0])
%         else
%             if t_real(j,i)>0
%                 line([limit limit],[0 0.2], 'color', [0.8 0 0])
%             else
%                 line([-limit -limit],[0 0.2], 'color', [0.8 0 0])
%             end
%         
%         end
%     end
% end
% disp(['Control vs ', ' after ', num2str(v), 'h']);
% disp(prctile(t_values, [2.5 97.5]));
% disp(t_real)
% p_value = (sum(y(1:25))+sum(y(976:1000)))/sum(y);
% disp(['p_value: ', num2str(p_value)])


