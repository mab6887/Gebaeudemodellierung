data = readtable("Measurements.txt");

dataBefore = data %[output:440f9198]

% Fill outliers: Entfernt Werte die sich innerhalb kurzer Zeit zu stark von
% Nachbarwerten unterscheiden
data = filloutliers(data,"linear","movmedian",50, ...
    "ThresholdFactor",10, ...
    "DataVariables",["T_Amb_degC","EG_LivingKitchen_degC", ...
    "EG_HallwayEntrance_degC","EG_Utilities_degC","EG_Dressing_degC", ...
    "EG_Sleeping_degC","EG_Bath_degC","EG_GuestBath_degC","OG_Office_degC", ...
    "OG_Sleeping_degC","OG_Bath_degC"]);

% Fill outliers
outlierIndices = ~isbetween(data,0,6.9,"DataVariables","Q_heat");
data = filloutliers(data,"linear","OutlierLocations",outlierIndices, ...
    "DataVariables","Q_heat");

% Fill outliers
outlierIndices = ~isbetween(data,0,14,"DataVariables","Q_int");
data = filloutliers(data,"linear","OutlierLocations",outlierIndices, ...
    "DataVariables","Q_int");



% Entfernung nicht verwertbarer Zeiträume (kleiener Puffer davor und
% danach)

% Entfernung 01.11 9:30 - 09.11 18:00 hier fast alle Sensoren Q_sol fast
% komplett
startTime = datetime('01-Nov-2023 09:30:00');
endTime = datetime('09-Nov-2023 18:00:00');
rowsToDelete = data.timestamps >= startTime & data.timestamps <= endTime;
data(rowsToDelete, :) = [];

% Entfernung 17.11 09:30 - 01.12 12:00 viele Sensoren konstant (Zeitraum verlängert wegen Q_heat &
% T_amb
startTime = datetime('17-Nov-2023 09:30:00');
endTime = datetime('01-Dec-2023 12:00:00');
rowsToDelete = data.timestamps >= startTime & data.timestamps <= endTime;
data(rowsToDelete, :) = [];

% Entfernung 21.02 12:00 - 23.02 12:00 (Q_heat ausgefallen)
startTime = datetime('21-Feb-2024 12:00:00');
endTime = datetime('23-Feb-2024 12:00:00');
rowsToDelete = data.timestamps >= startTime & data.timestamps <= endTime;
data(rowsToDelete, :) = [];

% Entfernung 29.02 00:00 - 01.03 00:00 (Q_int ausgefallen)
startTime = datetime('29-Feb-2024 00:00:00');
endTime = datetime('01-Mar-2024 00:00:00');
rowsToDelete = data.timestamps >= startTime & data.timestamps <= endTime;
data(rowsToDelete, :) = [];

% Entfernung 13.03 00:00 - 14.03 12:00 (Q_heat & Q_sol ausgefallen)
startTime = datetime('13-Mar-2024 00:00:00');
endTime = datetime('14-Mar-2024 12:00:00');
rowsToDelete = data.timestamps >= startTime & data.timestamps <= endTime;
data(rowsToDelete, :) = [];

cleanedData = data %[output:5278d632]

writetable(data,"cleanedData")

%[appendix]
%---
%[metadata:view]
%   data: {"layout":"onright","rightPanelPercent":33.7}
%---
%[output:440f9198]
%   data: {"dataType":"tabular","outputData":{"columnNames":["timestamps","T_Amb_degC","Q_heat","Q_sol","Q_int","EG_LivingKitchen_degC","EG_HallwayEntrance_degC","EG_Utilities_degC","EG_Dressing_degC","EG_Sleeping_degC","EG_Bath_degC","EG_GuestBath_degC","EG_Server_degC","OG_Office_degC","OG_Sleeping_degC","OG_Bath_degC"],"columns":16,"dataTypes":["datetime","double","double","double","double","double","double","double","double","double","double","double","double","double","double","double"],"header":"23231×16 table","name":"dataBefore","rows":23231,"type":"table","value":[["01-Sep-2023 00:15:00","15.2000","0","0","1","21.2200","23.8600","23.2400","22.4000","22.9400","22.5000","23.8400","28.1800","21.8600","21.4400","23.3200"],["01-Sep-2023 00:30:00","15.0667","0","0","1.0367","21.1409","23.8600","23.2000","22.4333","23.0067","22.4600","23.8467","28.1800","21.8800","21.4267","23.3067"],["01-Sep-2023 00:45:00","14.7000","0","0","0.9632","21.0804","23.8798","23.2133","22.4333","23.0200","22.4467","23.8667","26.8600","21.8600","21.3867","23.3000"],["01-Sep-2023 01:00:00","14.5000","0","0","2.5397","20.9405","23.8403","23.1667","22.4200","23","22.4400","23.8400","26.2000","21.8533","21.3733","23.2933"],["01-Sep-2023 01:15:00","14.1333","0","0","1.0765","20.9203","23.8597","23.1600","22.4267","23.0133","22.4467","23.8533","26.2000","21.8467","21.3267","23.2800"],["01-Sep-2023 01:30:00","13.8667","0","0","0.9043","20.8405","23.8603","23.1133","22.4267","23.0600","22.4333","23.8400","26.2000","21.8533","21.3067","23.2733"],["01-Sep-2023 01:45:00","13.7667","0","0","0.7477","20.8600","23.8795","23.1067","22.4467","23.0667","22.4333","23.8333","26.2000","21.8400","21.2800","23.2733"],["01-Sep-2023 02:00:00","13.8000","0","0","0.8006","20.8200","23.8403","23.0867","22.4333","23.0733","22.4067","23.8267","26.2000","21.8333","21.2467","23.2600"],["01-Sep-2023 02:15:00","13.9667","0","0","0.7519","20.7803","23.8595","23.0600","22.4200","23.0867","22.4133","23.8067","26.2000","21.8267","21.2400","23.2600"],["01-Sep-2023 02:30:00","14.0333","0","0","0.7831","20.7995","23.8597","23.0600","22.4400","23.0867","22.4267","23.8200","26.2000","21.8000","21.2200","23.2467"],["01-Sep-2023 02:45:00","14.2000","0","0","0.8041","20.8200","23.8797","23.0200","22.4267","23.0533","22.4133","23.8000","26.2000","21.8000","21.2267","23.2333"],["01-Sep-2023 03:00:00","14.7333","0","0","0.7968","20.8400","23.9000","23.0267","22.4200","23.0467","22.4000","23.8067","26.2000","21.7867","21.2133","23.2333"],["01-Sep-2023 03:15:00","14.3333","0","0","0.7851","20.8795","23.9000","23.0067","22.4200","23.0467","22.4000","23.7933","26.2000","21.8000","21.2200","23.2267"],["01-Sep-2023 03:30:00","14.2667","0","0","0.7878","20.8404","23.9400","23.0067","22.4133","23.0533","22.4067","23.8067","26.2000","21.8000","21.2267","23.2200"]]}}
%---
%[output:5278d632]
%   data: {"dataType":"tabular","outputData":{"columnNames":["timestamps","T_Amb_degC","Q_heat","Q_sol","Q_int","EG_LivingKitchen_degC","EG_HallwayEntrance_degC","EG_Utilities_degC","EG_Dressing_degC","EG_Sleeping_degC","EG_Bath_degC","EG_GuestBath_degC","EG_Server_degC","OG_Office_degC","OG_Sleeping_degC","OG_Bath_degC"],"columns":16,"dataTypes":["datetime","double","double","double","double","double","double","double","double","double","double","double","double","double","double","double"],"header":"20638×16 table","name":"cleanedData","rows":20638,"type":"table","value":[["01-Sep-2023 00:15:00","15.2000","0","0","1","21.2200","23.8600","23.2400","22.4000","22.9400","22.5000","23.8400","28.1800","21.8600","21.4400","23.3200"],["01-Sep-2023 00:30:00","15.0667","0","0","1.0367","21.1409","23.8600","23.2000","22.4333","23.0067","22.4600","23.8467","28.1800","21.8800","21.4267","23.3067"],["01-Sep-2023 00:45:00","14.7000","0","0","0.9632","21.0804","23.8798","23.2133","22.4333","23.0200","22.4467","23.8667","26.8600","21.8600","21.3867","23.3000"],["01-Sep-2023 01:00:00","14.5000","0","0","2.5397","20.9405","23.8403","23.1667","22.4200","23","22.4400","23.8400","26.2000","21.8533","21.3733","23.2933"],["01-Sep-2023 01:15:00","14.1333","0","0","1.0765","20.9203","23.8597","23.1600","22.4267","23.0133","22.4467","23.8533","26.2000","21.8467","21.3267","23.2800"],["01-Sep-2023 01:30:00","13.8667","0","0","0.9043","20.8405","23.8603","23.1133","22.4267","23.0600","22.4333","23.8400","26.2000","21.8533","21.3067","23.2733"],["01-Sep-2023 01:45:00","13.7667","0","0","0.7477","20.8600","23.8795","23.1067","22.4467","23.0667","22.4333","23.8333","26.2000","21.8400","21.2800","23.2733"],["01-Sep-2023 02:00:00","13.8000","0","0","0.8006","20.8200","23.8403","23.0867","22.4333","23.0733","22.4067","23.8267","26.2000","21.8333","21.2467","23.2600"],["01-Sep-2023 02:15:00","13.9667","0","0","0.7519","20.7803","23.8595","23.0600","22.4200","23.0867","22.4133","23.8067","26.2000","21.8267","21.2400","23.2600"],["01-Sep-2023 02:30:00","14.0333","0","0","0.7831","20.7995","23.8597","23.0600","22.4400","23.0867","22.4267","23.8200","26.2000","21.8000","21.2200","23.2467"],["01-Sep-2023 02:45:00","14.2000","0","0","0.8041","20.8200","23.8797","23.0200","22.4267","23.0533","22.4133","23.8000","26.2000","21.8000","21.2267","23.2333"],["01-Sep-2023 03:00:00","14.7333","0","0","0.7968","20.8400","23.9000","23.0267","22.4200","23.0467","22.4000","23.8067","26.2000","21.7867","21.2133","23.2333"],["01-Sep-2023 03:15:00","14.3333","0","0","0.7851","20.8795","23.9000","23.0067","22.4200","23.0467","22.4000","23.7933","26.2000","21.8000","21.2200","23.2267"],["01-Sep-2023 03:30:00","14.2667","0","0","0.7878","20.8404","23.9400","23.0067","22.4133","23.0533","22.4067","23.8067","26.2000","21.8000","21.2267","23.2200"]]}}
%---
