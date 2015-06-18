rat = 'kontrola15';
path = ['C:\Users\L635-10K\Desktop\lic_fiz\dane\',rat,'\'];
% 
% maks = zeros(4, 300);

% for v=1:length(veps)
%     load([path, 'kontrola15_VEP',num2str(veps(v)),'.mat'])
%     for t=1:300
%         maks(v, t) = max(all_dataTrial(8, 51:75, t))-min(all_dataTrial(8, 51:75, t));
%         if maks(v,t) <0
%             disp('ERROR!')
%         end          
%     end 
% end
% N = 5000;
% sred = zeros(4,N);
% for j=1:4
%     for i=1:N
%         a = randi(300, 300, 1);
%         sred(j,i) = mean(maks(j,a));
%     end
% end
% 
% 
% 
% for i=2:4
%     p = ranksum(maks(1,:), maks(i,:));
%     disp(['VEP1 i VEP', num2str(i)])
%     disp(p)
% end
% 
% for i=1:4
% prctile(sred(i, :),[2.5 97.5])
% %prctile(maks(i, :),[0 95])
% end
% 
%% Odtad jest dobra, dzialajaca wersja
% 
% sred = zeros(4, 300,6);
% veps = [1,5,9,13];
% for v=1:length(veps)
%     load([path, 'kontrola15_VEP',num2str(veps(v)),'.mat'])
%     for i = 1:6
%         sred(v,:,i) = mean(all_dataTrial(1, :, 50*(i-1)+i:50*i),3);
%     end
% end
% maks = zeros(4,6);
% for v=1:length(veps)
%     for t=1:6
%         maks(v, t) = max(sred(v, 51:75, t))-min(sred(v, 51:75, t));
%         if maks(v,t) <0
%             disp('ERROR!')
%         end          
%     end 
% end
% 
% 
% for i=2:4
%     %p = mwwtest(maks(1,:), maks(i,:));
%     p = ranksum(maks(1,:), maks(i,:));
%     disp(['VEP1 i VEP', num2str(i)])
%     disp(p)
% end


%losowanko
l_sred = 6;
veps = [1,5,9,13];
%veps = [1, 7, 11, 15];
%veps = [1,8,12,16];
struction = 'LGN';
chans = [27:31];
sred = zeros(length(chans),length(veps), 300, l_sred);

for v=1:length(veps)
    load([path, rat,'_VEP',num2str(veps(v)),'.mat'])
    for c=1:length(chans)
        for r = 1:l_sred
            %a = randperm(300,50);
            a = randi(200,50,1);
            sred(c, v,:,r) = mean(all_dataTrial(chans(c), :, a),3);
        end
    end
end

amplituda = zeros(length(chans), length(veps),l_sred);

for v=1:length(veps)
    for c=1:length(chans)
        for t=1:l_sred
            amplituda(c,v, t) = abs(max(sred(c,v, 51:75, t)))+abs(min(sred(c,v, 51:75, t)));
            if amplituda(c,v,t) <0
                disp('ERROR!')
            end  
        end
    end 
end

%plot(squeeze(sred(1,:,:)))
p_val = zeros(length(chans), 3);
for c=1:length(chans)
    for i=2:4
        p = ranksum(squeeze(amplituda(c,1,:)), squeeze(amplituda(c,i,:)));
        p_val(c,i-1) = p;
    end
end

bw_legend = {'kontrola', 'po 1 h','po 2 h','po 3 h'};
bw_colormap = [0.5 0.5 0.5; 0 0 0.9; 0 0.9 0; 0.9 0 0];

% subplot(2,1,1)
% barweb([squeeze(mean(amplituda(1,:,:),3));squeeze(mean(amplituda(2,:,:),3))],[std(squeeze(amplituda(1,:,:)),0,2)';std(squeeze(amplituda(2,:,:)),0,2)'], 0.9,{'CxC1'; 'CxC4'},[] , [], 'Amplituda [uV]', bw_colormap, 'y', bw_legend, 2, 'plot');
% subplot(2,1,2)
% barweb([squeeze(mean(amplituda(3,:,:),3));squeeze(mean(amplituda(4,:,:),3))],[std(squeeze(amplituda(3,:,:)),0,2)';std(squeeze(amplituda(4,:,:)),0,2)'], 0.9,{'CxC8'; 'CxC10'},[] , [], 'Amplituda [uV]', bw_colormap, 'y', bw_legend, 2, 'axis');
ha = tight_subplot(1,5, 0.05, [0.05 0.1], [0.1 0.05]);
for i=1:5
    axes(ha(i));
    %figure()
    if i == 1
    %barweb(squeeze(mean(amplituda(i,:,:),3)),std(squeeze(amplituda(i,:,:)),0,2)', 0.9,[],['CxC', num2str(chans(i))] , [], 'Amplituda [uV]', bw_colormap, 'y', [], 2, []);
    barweb(squeeze(mean(amplituda(i,:,:),3)),std(squeeze(amplituda(i,:,:)),0,2)', 0.9,[],[struction, num2str(chans(i)-23)] , [], 'Amplituda [uV]', bw_colormap, 'y',[], 2, []);
    elseif i<5
    barweb(squeeze(mean(amplituda(i,:,:),3)),std(squeeze(amplituda(i,:,:)),0,2)', 0.9,[],[struction, num2str(chans(i)-23)] , [], [], bw_colormap, 'y', [], 2, []);
    else
        barweb([NaN, NaN, NaN, NaN], [NaN, NaN, NaN, NaN], 0.9, [], [], [],[], bw_colormap, [], bw_legend,1,'plot')
        %barweb(zeros(4,1), zeros(4,1), [], [], [], [],[], bw_colormap, [], bw_legend,[],[])
        set(gca,'xtick',[],'ytick',[])
        axis off
    end
    print(gcf,'-dpng','-r300', [path,rat, '_stat_',struction,'.png']) 
end
save([path,rat,'_stat_',struction,'.mat'], 'amplituda')


