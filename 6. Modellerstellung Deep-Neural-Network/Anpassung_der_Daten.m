%erste 12 Zeitschritte müssen entfernt werden, da vergangene 3h relevant
%sind zur berechnung. letzte 96 auch weg, da keine messergebnisse in der
%zukunft
%Shift der realen 12 nach hinten (überprüfen ob 96 weitere richtig
%definiert, einfügen der Datums geshiftet(Übernahme von D angepasst)

D = readtable("normalizedData.txt")

% Define the column names
columnNames = {'T_amb_avg_last_3hours', 'T_amb_avg_following_24hours', ...
               'Q_heating_last_3hours', 'Q_heating_following_24hours', ...
               'Q_solar_last_3hours', 'Q_solar_following_24hours', ...
               'Q_internal_last_3hours', 'Q_internal_following_24hours', ...
               'EG_LivingKitchen_degC', 'EG_HallwayEntrance_degC',  ...
               'EG_Utilities_degC', 'EG_Dressing_degC',  ... 
               'EG_Sleeping_degC', 'EG_Bath_degC',  ... 
               'EG_GuestBath_degC', 'EG_Server_degC',  ...
               'OG_Office_degC', 'OG_Sleeping_degC',  ...
               'OG_Bath_degC', ...
               'EG_LivingKitchen_degC_24hours', 'EG_HallwayEntrance_degC_24hours', ...
               'EG_Utilities_degC_24hours', 'EG_Dressing_degC_24hours', ...
               'EG_Sleeping_degC_24hours', 'EG_Bath_degC_24hours', ...
               'EG_GuestBath_degC_24hours', 'EG_Server_degC_24hours', ...
               'OG_Office_degC_24hours', 'OG_Sleeping_degC_24hours', ...
               'OG_Bath_degC_24hours'};

% Number of columns
numColumns = length(columnNames);

% Create placeholder data (for demonstration, let's use random numbers)
% Assume we have 19 rows of data
numRows = 20638;
data = ones(numRows, numColumns);

% Create the table
T = array2table(data, 'VariableNames', columnNames);


% Filling the table with correct data


%T_amb_avg_last_3hours
    % Number of rows in the table D
    numRows = height(D);

    % Initialize the moving averages array
    movingAvg = NaN(numRows, 1);

    % Loop to calculate the moving average
    for i = 1:numRows-11
        % Calculate the average of the current 12 elements
        movingAvg(i) = mean(D{i:i+11, 'T_Amb_degC'});
    end
    % Insert the moving averages into T
    T.T_amb_avg_last_3hours = movingAvg;


%T_amb_avg_following_24hours
    % Number of rows in the table D
    numRowsD = height(D);
    numRowsT = height(T);

    % Initialize the sums array
    avgs = NaN(numRowsT, 1);

    % Loop to calculate the sums
    for i = 1:numRowsT
        if i + 12 + 95 <= numRowsD
            % Calculate the sum of the elements in the second column of D
            avgs(i) = mean(D{i+12:i+12+95, "T_Amb_degC"});
        end
    end

    % Insert the sums into the second column of T
    T.T_amb_avg_following_24hours = avgs;


%Q_heating_last_3hours
    % Initialize the moving averages array
    movingSum = NaN(numRows, 1);

    % Loop to calculate the moving total Energy in the last 3 hours
    for i = 1:numRows-11
        % Calculate Energy of the current 12 elements
        movingSum(i) = sum(D{i:i+11,'Q_heat'});
        
    end
    % Insert the moving averages into T
    T.Q_heating_last_3hours = movingSum;


%Q_heating_following_24hours
    % Initialize the sums array
    sums = NaN(numRowsT, 1);

    % Loop to calculate the sums
    for i = 1:numRowsT
        if i + 12 + 95 <= numRowsD
            % Calculate the sum of the elements in the second column of D
            sums(i) = sum(D{i+12:i+12+95, "Q_heat"});
        end
    end

    % Insert the sums into the second column of T
    T.Q_heating_following_24hours = sums;




%Q_solar_last_3hours
    % Loop to calculate the moving total Energy in the last 3 hours
    for i = 1:numRows-11
        % Calculate Energy of the current 12 elements
        movingSum(i) = sum(D{i:i+11,'Q_sol'});
        
    end
    % Insert the moving averages into T
    T.Q_solar_last_3hours = movingSum;

%Q_solar_following_24hours
    % Loop to calculate the sums
    for i = 1:numRowsT
        if i + 12 + 95 <= numRowsD
            % Calculate the sum of the elements in the second column of D
            sums(i) = sum(D{i+12:i+12+95, "Q_sol"});
        end
    end

    % Insert the sums into the second column of T
    T.Q_solar_following_24hours = sums;

%Q_internal_last_3hours
    % Loop to calculate the moving total Energy in the last 3 hours
    for i = 1:numRows-11
        % Calculate Energy of the current 12 elements
        movingSum(i) = sum(D{i:i+11,'Q_int'});
        
    end
    % Insert the moving averages into T
    T.Q_internal_last_3hours = movingSum

%Q_internal_following_24hours
    % Loop to calculate the sums
    for i = 1:numRowsT
        if i + 12 + 95 <= numRowsD
            % Calculate the sum of the elements in the second column of D
            sums(i) = sum(D{i+12:i+12+95, "Q_int"});
        end
    end

    % Insert the sums into the second column of T
    T.Q_internal_following_24hours = sums;

%%
%%Anpassung der Temperaturen

% Input Temperaturen müssen um 12 Schritte nach hinten geshiftet werden,
% damit 3h Trägheit des Gebäudes berücksichtigt wird
    
%EG_LivingKitchen_degC
% Number of rows in the table D
    numRowsD = height(D);
    numRowsT = height(T);

    % Initialize the shifted values array
    shiftedValues = NaN(numRowsT, 1);

    % Loop to shift the values by 12 rows
    for i = 1:numRowsT
        if i + 12 <= numRowsD
            % Copy the values from the second column of D shifted by 96 rows
            shiftedValues(i) = D{i+12, 'EG_LivingKitchen_degC'};
        end
    end

    % Insert the shifted values into the first column of T
    T.EG_LivingKitchen_degC = shiftedValues;


%EG_HallwayEntrance_degC
% Loop to shift the values by 12 rows
    for i = 1:numRowsT
        if i + 12 <= numRowsD
            % Copy the values from the second column of D shifted by 96 rows
            shiftedValues(i) = D{i+12, 'EG_HallwayEntrance_degC'};
        end
    end

T.EG_HallwayEntrance_degC = shiftedValues;


%EG_Utilities_degC
% Loop to shift the values by 12 rows
    for i = 1:numRowsT
        if i + 12 <= numRowsD
            % Copy the values from the second column of D shifted by 96 rows
            shiftedValues(i) = D{i+12, 'EG_Utilities_degC'};
        end
    end

T.EG_Utilities_degC = shiftedValues;


%EG_Dressing_degC
% Loop to shift the values by 12 rows
    for i = 1:numRowsT
        if i + 12 <= numRowsD
            % Copy the values from the second column of D shifted by 96 rows
            shiftedValues(i) = D{i+12, 'EG_Dressing_degC'};
        end
    end

T.EG_Dressing_degC = shiftedValues;


%EG_Sleeping_degC
% Loop to shift the values by 12 rows
    for i = 1:numRowsT
        if i + 12 <= numRowsD
            % Copy the values from the second column of D shifted by 96 rows
            shiftedValues(i) = D{i+12, 'EG_Sleeping_degC'};
        end
    end

T.EG_Sleeping_degC = shiftedValues;


%EG_Bath_degC
% Loop to shift the values by 12 rows
    for i = 1:numRowsT
        if i + 12 <= numRowsD
            % Copy the values from the second column of D shifted by 96 rows
            shiftedValues(i) = D{i+12, 'EG_Bath_degC'};
        end
    end

T.EG_Bath_degC = shiftedValues;


%EG_GuestBath_degC
% Loop to shift the values by 12 rows
    for i = 1:numRowsT
        if i + 12 <= numRowsD
            % Copy the values from the second column of D shifted by 96 rows
            shiftedValues(i) = D{i+12, 'EG_GuestBath_degC'};
        end
    end

T.EG_GuestBath_degC = shiftedValues;


%EG_Server_degC
% Loop to shift the values by 12 rows
    for i = 1:numRowsT
        if i + 12 <= numRowsD
            % Copy the values from the second column of D shifted by 96 rows
            shiftedValues(i) = D{i+12, 'EG_Server_degC'};
        end
    end

T.EG_Server_degC = shiftedValues;


%OG_Office_degC
% Loop to shift the values by 12 rows
    for i = 1:numRowsT
        if i + 12 <= numRowsD
            % Copy the values from the second column of D shifted by 96 rows
            shiftedValues(i) = D{i+12, 'OG_Office_degC'};
        end
    end

   
T.OG_Office_degC = shiftedValues;


%OG_Sleeping_degC
% Loop to shift the values by 12 rows
    for i = 1:numRowsT
        if i + 12 <= numRowsD
            % Copy the values from the second column of D shifted by 96 rows
            shiftedValues(i) = D{i+12, 'OG_Sleeping_degC'};
        end
    end

T.OG_Sleeping_degC = shiftedValues;


%OG_Bath_degC
% Loop to shift the values by 12 rows
    for i = 1:numRowsT
        if i + 12 <= numRowsD
            % Copy the values from the second column of D shifted by 96 rows
            shiftedValues(i) = D{i+12, 'OG_Bath_degC'};
        end
    end

T.OG_Bath_degC = shiftedValues;

%%


%EG_LivingKitchen_degC_24hours
    % Loop to shift the values by 108 rows
    for i = 1:numRowsT
        if i + 108 <= numRowsD
            % Copy the values from the second column of D shifted by 96 rows
            shiftedValues(i) = D{i+108, 'EG_LivingKitchen_degC'};
        end
    end

    % Insert the shifted values into the first column of T
    T.EG_LivingKitchen_degC_24hours = shiftedValues;


%EG_HallwayEntrance_degC_24hours
 % Loop to shift the values by 108 rows
    for i = 1:numRowsT
        if i + 108 <= numRowsD
            % Copy the values from the second column of D shifted by 96 rows
            shiftedValues(i) = D{i+108, 'EG_HallwayEntrance_degC'};
        end
    end

    % Insert the shifted values into the first column of T
    T.EG_HallwayEntrance_degC_24hours = shiftedValues;


%EG_Utilities_degC_24hours
 % Loop to shift the values by 108 rows
    for i = 1:numRowsT
        if i + 108 <= numRowsD
            % Copy the values from the second column of D shifted by 96 rows
            shiftedValues(i) = D{i+108, 'EG_Utilities_degC'};
        end
    end

    % Insert the shifted values into the first column of T
    T.EG_Utilities_degC_24hours = shiftedValues;


%EG_Dressing_degC_24hours
 % Loop to shift the values by 108 rows
    for i = 1:numRowsT
        if i + 108 <= numRowsD
            % Copy the values from the second column of D shifted by 96 rows
            shiftedValues(i) = D{i+108, 'EG_Dressing_degC'};
        end
    end

    % Insert the shifted values into the first column of T
    T.EG_Dressing_degC_24hours = shiftedValues;


%EG_Sleeping_degC_24hours
 % Loop to shift the values by 108 rows
    for i = 1:numRowsT
        if i + 108 <= numRowsD
            % Copy the values from the second column of D shifted by 96 rows
            shiftedValues(i) = D{i+108, 'EG_Sleeping_degC'};
        end
    end

    % Insert the shifted values into the first column of T
    T.EG_Sleeping_degC_24hours = shiftedValues;


%EG_Bath_degC_24hours
 % Loop to shift the values by 108 rows
    for i = 1:numRowsT
        if i + 108 <= numRowsD
            % Copy the values from the second column of D shifted by 96 rows
            shiftedValues(i) = D{i+108, 'EG_Bath_degC'};
        end
    end

    % Insert the shifted values into the first column of T
    T.EG_Bath_degC_24hours = shiftedValues;


%EG_GuestBath_degC_24hours
 % Loop to shift the values by 108 rows
    for i = 1:numRowsT
        if i + 108 <= numRowsD
            % Copy the values from the second column of D shifted by 96 rows
            shiftedValues(i) = D{i+108, 'EG_GuestBath_degC'};
        end
    end

    % Insert the shifted values into the first column of T
    T.EG_GuestBath_degC_24hours = shiftedValues;


%EG_Server_degC_24hours
 % Loop to shift the values by 108 rows
    for i = 1:numRowsT
        if i + 108 <= numRowsD
            % Copy the values from the second column of D shifted by 96 rows
            shiftedValues(i) = D{i+108, 'EG_Server_degC'};
        end
    end

    % Insert the shifted values into the first column of T
    T.EG_Server_degC_24hours = shiftedValues;


%OG_Office_degC_24hours
 % Loop to shift the values by 108 rows
    for i = 1:numRowsT
        if i + 108 <= numRowsD
            % Copy the values from the second column of D shifted by 96 rows
            shiftedValues(i) = D{i+108, 'OG_Office_degC'};
        end
    end

    % Insert the shifted values into the first column of T
    T.OG_Office_degC_24hours = shiftedValues;


%OG_Sleeping_degC_24hours
 % Loop to shift the values by 108 rows
    for i = 1:numRowsT
        if i + 108 <= numRowsD
            % Copy the values from the second column of D shifted by 96 rows
            shiftedValues(i) = D{i+108, 'OG_Sleeping_degC'};
        end
    end

    % Insert the shifted values into the first column of T
    T.OG_Sleeping_degC_24hours = shiftedValues;


%OG_Bath_degC_24hours
 % Loop to shift the values by 108 rows
    for i = 1:numRowsT
        if i + 108 <= numRowsD
            % Copy the values from the second column of D shifted by 96 rows
            shiftedValues(i) = D{i+108, 'OG_Bath_degC'};
        end
    end

    % Insert the shifted values into the first column of T
    T.OG_Bath_degC_24hours = shiftedValues;


%Entfernen der letzten 108 Zeilen (hier fehlen Messungen aus der Zukunft
%evtl)
T((end-108):end,:) = [];
%%

%Entfernung der ersten 12 timestamps aus den Messdaten 
timestamps = D.timestamps;
timestamps(20530:end,:) = [];

%Hinzufügen der korrekten Timestamps zur Rechenmatrix (relevant zur
%Aufteilung der Daten in Training, Validierung und Test)
T = addvars(T,timestamps,'NewVariableNames','timestamps','Before','T_amb_avg_last_3hours');

% Display the table
T
disp(T)
writetable(T,'DataDeepNN')