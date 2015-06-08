function wczytaj_mcrack(file_name)    
    %Importujê biobliotekê MCD do przeczytania pliku
    [nsresult] = ns_SetLibrary('Z:\Home\Porowska\nsMCDLibrary_3.7b\Matlab\Matlab-Import-Filter\Matlab_Interface\nsMCDLibrary64.dll');

    %Ustalam, na razie na sztywno œcie¿kê
    path_data = 'Z:\Dane doœwiadczalne\eyestim\Multichannel System Data\kontrola8\';


    %Otwieram plik, hfile - identyfikator otwartego pliku
    [nsresult, hfile] = ns_OpenFile([path_data,file_name,'.mcd']);

    disp('Otwarto plik!');
    %Wczytujê informacjê o pliku, w tym o liczbie kana³ów
    [nsresult,info]=ns_GetFileInfo(hfile);

    %Wczytuje informacje o kolejnoœci elektrod
    for entity_no = 1:info.EntityCount %liczba kana³ów McRackowych
        [nsresult,entity] = ns_GetEntityInfo(hfile,entity_no);
        channel_labels(entity_no,:) = entity.EntityLabel(end-4:end);%chcemy mieæ tylko skrótow¹ nazwê. Szukamy zmiennej D1.
    end

    %Interesuje nas tylko D1 i pierwsza elektroda
    ind_D1 = 1;
    ind_ost= 1;
    for i=1:length(channel_labels)
        if strcmp(channel_labels(i:65:65*5),'   D1') == 1
            ind_D1 = i;
        end
        if strcmp(channel_labels(i:65:65*5),'D1 15') == 1
            ind_ost = i;
        end
    end
    [nsresult,entity] = ns_GetEntityInfo(hfile,ind_D1);
    length_D1 = entity.ItemCount; %d³ugoœæ wektora D1

    %Tu jest zawarta informacja o próbkowaniu
    [nsresult,analog] = ns_GetAnalogInfo(hfile,ind_D1);
    [nsresult,count, D1] = ns_GetAnalogData(hfile,ind_D1, 1,entity.ItemCount);

    sample_rate = analog.SampleRate;


    %tu oczywiscie mo¿na modyfikowaæ pod³ug potrzeb ;)
    docelowe_Fs = 1000;

    kanaly = [] %z komba
    all_data = zeros(length(kanaly), length_D1/20);


    for kanal = 1:length(kanaly)
        [nsresult,entity] = ns_GetEntityInfo(hfile,kanaly(kanal)+ind_ost);
        [nsresult,count,data] = ns_GetAnalogData(hfile,kanaly(kanal)+ind_ost,1,entity.ItemCount);
        signal = obrob(data, sample_rate);
        all_data(kanal, :) = signal;
        disp(kanal);
    end

    save([file_name, '_1000Hz.mat'],'all_data');
end