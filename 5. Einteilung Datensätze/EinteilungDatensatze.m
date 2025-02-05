% Einteilung Datensätze (hier nur zur Übersichtlichkeit: Dieser Code wurde
% in den Code des NarxModels übernoemmen)
% ohne Entfernung von nicht verwertbaren Zeitabschnitten wäre eine
% einfachee automatische Einteilung durch eine for Schleife möglich

D = readtimetable("normalizedData") %[output:3e342309]

%Einteilung des Datensatzes periodisch in 2 Wochen Training, 1 Woche
%Validierung, 1 Woche Test
%Dafinition: Woche startet wie Datensatz -> hier 01.09.2023 00.15 und endet
%7 Tage später um 00:00
% Sampling in 15min Takt -> in diesem Beispiel 672 Zeilen pro Woche

%Training

sIv1 = datetime('01-Sep-2023 00:15:00');
eIv1 = datetime('15-Sep-2023 00:00:00');
sIv2 = datetime('29-Sep-2023 00:15:00');
eIv2 = datetime('13-Oct-2023 00:00:00');
sIv3 = datetime('27-Oct-2023 00:15:00');
eIv3 = datetime('17-Nov-2023 09:15:00');
sIv4 = datetime('15-Dec-2023 00:15:00');
eIv4 = datetime('29-Dec-2023 00:00:00');
sIv5 = datetime('12-Jan-2024 00:15:00');
eIv5 = datetime('26-Jan-2024 00:00:00');
sIv6 = datetime('09-Feb-2024 00:15:00');
eIv6 = datetime('21-Feb-2024 11:45:00');
sIv7 = datetime('08-Mar-2024 00:15:00');
eIv7 = datetime('22-Mar-2024 00:00:00');
sIv8 = datetime('05-Apr-2024 00:15:00');
eIv8 = datetime('19-Apr-2024 00:00:00');

Training =     [find(D.timestamps >= sIv1 & D.timestamps <= eIv1)  %[output:group:3e427486] %[output:92b7ca0e]
                find(D.timestamps >= sIv2 & D.timestamps <= eIv2) %[output:92b7ca0e]
                find(D.timestamps >= sIv3 & D.timestamps <= eIv3) %[output:92b7ca0e]
                find(D.timestamps >= sIv4 & D.timestamps <= eIv4) %[output:92b7ca0e]
                find(D.timestamps >= sIv5 & D.timestamps <= eIv5) %[output:92b7ca0e]
                find(D.timestamps >= sIv6 & D.timestamps <= eIv6) %[output:92b7ca0e]
                find(D.timestamps >= sIv7 & D.timestamps <= eIv7) %[output:92b7ca0e]
                find(D.timestamps >= sIv8 & D.timestamps <= eIv8)] %[output:group:3e427486] %[output:92b7ca0e]

%Validierung

sIv1 = datetime('15-Sep-2023 00:15:00');
eIv1 = datetime('22-Sep-2023 00:00:00');
sIv2 = datetime('13-Oct-2023 00:15:00');
eIv2 = datetime('20-Oct-2023 00:00:00');
sIv3 = datetime('01-Dec-2023 12:15:00');
eIv3 = datetime('08-Dec-2023 00:00:00');
sIv4 = datetime('29-Dec-2023 00:15:00');
eIv4 = datetime('05-Jan-2024 00:00:00');
sIv5 = datetime('26-Jan-2024 00:15:00');
eIv5 = datetime('02-Feb-2024 00:00:00');
sIv6 = datetime('23-Feb-2024 12:15:00');
eIv6 = datetime('28-Feb-2024 23:45:00');
sIv7 = datetime('22-Mar-2024 00:15:00');
eIv7 = datetime('29-Mar-2024 00:00:00');
sIv8 = datetime('19-Apr-2024 00:15:00');
eIv8 = datetime('26-Apr-2024 00:00:00');

Validierung =  [find(D.timestamps >= sIv1 & D.timestamps <= eIv1)  %[output:group:6c4040c9] %[output:17008ce8]
                find(D.timestamps >= sIv2 & D.timestamps <= eIv2) %[output:17008ce8]
                find(D.timestamps >= sIv3 & D.timestamps <= eIv3) %[output:17008ce8]
                find(D.timestamps >= sIv4 & D.timestamps <= eIv4) %[output:17008ce8]
                find(D.timestamps >= sIv5 & D.timestamps <= eIv5) %[output:17008ce8]
                find(D.timestamps >= sIv6 & D.timestamps <= eIv6) %[output:17008ce8]
                find(D.timestamps >= sIv7 & D.timestamps <= eIv7) %[output:17008ce8]
                find(D.timestamps >= sIv8 & D.timestamps <= eIv8)] %[output:group:6c4040c9] %[output:17008ce8]

%Test

sIv1 = datetime('22-Sep-2023 00:15:00');
eIv1 = datetime('29-Sep-2023 00:00:00');
sIv2 = datetime('20-Oct-2023 00:15:00');
eIv2 = datetime('27-Oct-2023 00:00:00');
sIv3 = datetime('08-Dec-2023 00:15:00');
eIv3 = datetime('15-Dec-2023 00:00:00');
sIv4 = datetime('05-Jan-2024 00:15:00');
eIv4 = datetime('12-Jan-2024 00:00:00');
sIv5 = datetime('02-Feb-2024 00:15:00');
eIv5 = datetime('09-Feb-2024 00:00:00');
sIv6 = datetime('01-Mar-2024 00:15:00');
eIv6 = datetime('08-Mar-2024 00:00:00');
sIv7 = datetime('29-Mar-2024 00:15:00');
eIv7 = datetime('05-Apr-2024 00:00:00');
sIv8 = datetime('26-Apr-2024 00:15:00');
eIv8 = datetime('29-Apr-2024 23:45:00');

Test =         [find(D.timestamps >= sIv1 & D.timestamps <= eIv1)  %[output:group:38edc88d] %[output:0c2c2cc8]
                find(D.timestamps >= sIv2 & D.timestamps <= eIv2) %[output:0c2c2cc8]
                find(D.timestamps >= sIv3 & D.timestamps <= eIv3) %[output:0c2c2cc8]
                find(D.timestamps >= sIv4 & D.timestamps <= eIv4) %[output:0c2c2cc8]
                find(D.timestamps >= sIv5 & D.timestamps <= eIv5) %[output:0c2c2cc8]
                find(D.timestamps >= sIv6 & D.timestamps <= eIv6) %[output:0c2c2cc8]
                find(D.timestamps >= sIv7 & D.timestamps <= eIv7) %[output:0c2c2cc8]
                find(D.timestamps >= sIv8 & D.timestamps <= eIv8)] %[output:group:38edc88d] %[output:0c2c2cc8]

%Test: Summe der Höhe von Training, Validierung & Test müssen Höhe der
%vorherigen Matrix entsprechen 

h = height(D) %[output:7d28f2fa]
H = height(Training) + height(Validierung) + height(Test) %[output:59394855]

% Einteilung im Modell
% [trainInd,valInd,testInd] = divideind(24,Training,Validierung,Test)



%[appendix]
%---
%[metadata:view]
%   data: {"layout":"onright","rightPanelPercent":40}
%---
%[output:3e342309]
%   data: {"dataType":"tabular","outputData":{"columnNames":["timestamps","T_Amb_degC","Q_heat","Q_sol","Q_int","EG_LivingKitchen_degC","EG_HallwayEntrance_degC","EG_Utilities_degC","EG_Dressing_degC","EG_Sleeping_degC","EG_Bath_degC","EG_GuestBath_degC","EG_Server_degC","OG_Office_degC","OG_Sleeping_degC","OG_Bath_degC"],"columns":16,"dataTypes":["datetime","double","double","double","double","double","double","double","double","double","double","double","double","double","double","double"],"header":"20638×15 timetable","name":"D","rows":20638,"type":"timetable","value":[["01-Sep-2023 00:15:00","0.6520","0","0","0.0333","0.7122","0.7386","0.7324","0.7240","0.7294","0.7250","0.7384","0.7818","0.7186","0.7144","0.7332"],["01-Sep-2023 00:30:00","0.6507","0","0","0.0346","0.7114","0.7386","0.7320","0.7243","0.7301","0.7246","0.7385","0.7818","0.7188","0.7143","0.7331"],["01-Sep-2023 00:45:00","0.6470","0","0","0.0321","0.7108","0.7388","0.7321","0.7243","0.7302","0.7245","0.7387","0.7686","0.7186","0.7139","0.7330"],["01-Sep-2023 01:00:00","0.6450","0","0","0.0847","0.7094","0.7384","0.7317","0.7242","0.7300","0.7244","0.7384","0.7620","0.7185","0.7137","0.7329"],["01-Sep-2023 01:15:00","0.6413","0","0","0.0359","0.7092","0.7386","0.7316","0.7243","0.7301","0.7245","0.7385","0.7620","0.7185","0.7133","0.7328"],["01-Sep-2023 01:30:00","0.6387","0","0","0.0301","0.7084","0.7386","0.7311","0.7243","0.7306","0.7243","0.7384","0.7620","0.7185","0.7131","0.7327"],["01-Sep-2023 01:45:00","0.6377","0","0","0.0249","0.7086","0.7388","0.7311","0.7245","0.7307","0.7243","0.7383","0.7620","0.7184","0.7128","0.7327"],["01-Sep-2023 02:00:00","0.6380","0","0","0.0267","0.7082","0.7384","0.7309","0.7243","0.7307","0.7241","0.7383","0.7620","0.7183","0.7125","0.7326"],["01-Sep-2023 02:15:00","0.6397","0","0","0.0251","0.7078","0.7386","0.7306","0.7242","0.7309","0.7241","0.7381","0.7620","0.7183","0.7124","0.7326"],["01-Sep-2023 02:30:00","0.6403","0","0","0.0261","0.7080","0.7386","0.7306","0.7244","0.7309","0.7243","0.7382","0.7620","0.7180","0.7122","0.7325"],["01-Sep-2023 02:45:00","0.6420","0","0","0.0268","0.7082","0.7388","0.7302","0.7243","0.7305","0.7241","0.7380","0.7620","0.7180","0.7123","0.7323"],["01-Sep-2023 03:00:00","0.6473","0","0","0.0266","0.7084","0.7390","0.7303","0.7242","0.7305","0.7240","0.7381","0.7620","0.7179","0.7121","0.7323"],["01-Sep-2023 03:15:00","0.6433","0","0","0.0262","0.7088","0.7390","0.7301","0.7242","0.7305","0.7240","0.7379","0.7620","0.7180","0.7122","0.7323"],["01-Sep-2023 03:30:00","0.6427","0","0","0.0263","0.7084","0.7394","0.7301","0.7241","0.7305","0.7241","0.7381","0.7620","0.7180","0.7123","0.7322"]]}}
%---
%[output:92b7ca0e]
%   data: {"dataType":"matrix","outputData":{"columns":1,"name":"Training","rows":10372,"type":"double","value":[["1"],["2"],["3"],["4"],["5"],["6"],["7"],["8"],["9"],["10"]]}}
%---
%[output:17008ce8]
%   data: {"dataType":"matrix","outputData":{"columns":1,"name":"Validierung","rows":5183,"type":"double","value":[["1345"],["1346"],["1347"],["1348"],["1349"],["1350"],["1351"],["1352"],["1353"],["1354"]]}}
%---
%[output:0c2c2cc8]
%   data: {"dataType":"matrix","outputData":{"columns":1,"name":"Test","rows":5083,"type":"double","value":[["2017"],["2018"],["2019"],["2020"],["2021"],["2022"],["2023"],["2024"],["2025"],["2026"]]}}
%---
%[output:7d28f2fa]
%   data: {"dataType":"textualVariable","outputData":{"name":"h","value":"20638"}}
%---
%[output:59394855]
%   data: {"dataType":"textualVariable","outputData":{"name":"H","value":"20638"}}
%---
