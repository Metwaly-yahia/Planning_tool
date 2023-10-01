clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
channels = 340 ;            % channels: Number of Channels
frequency = 900;        % frequency(MHz): Frequency Band
BS_height = 20 ;            % BS_height: Height of the base station
MS_height = 1.5 ;           % MS_height: Height of the mobile station
MS_sensitivity_dbm = -95;  % MS_sensitivity_dbm: Sensitivity of mobile station in dbm
Au = 0.025 ;                % Au: Traffic Intensity per user
n = 4 ;                     % n: Path Loss Exponent

%%%%%%%%%%%%%%%%%%%%%%Question 1%%%%%%%%%%%%%%%%%%%%%%%%%%%%
GOS = 0.02; %input('Enter the GOS Value');
city_area = 100000; %input('Enter the area of your city');
user_density = 1.4e-3 ; %input('Enter the Density');   % user_density: Total number of users (u).
SIR_db = 1:1:30; %input('Enter the SIR Value in db');
%sector_method = 120; %input('Enter the sectorization method','s'); % sector_method: sectorization method.
for i=[6,2,1]   %diffrent values for diffrent sectorization
        for j=1:length(SIR_db)
                   SIR_ratio(j) = power(10 , (SIR_db(j)/10) );   %convert from dB
                   cells_per_custer(j) = power( (SIR_ratio(j) * i), (2/n) )/3 ;  %intial value for N
                   N(j)=calc_cluster_size(cells_per_custer(j));   %choose possible number for N
        end
        figure (1)
        plot(SIR_db,N); 
        ylabel('N'), xlabel('SIRdb');
        title(['cluster size Vs. SIRdb(min)']);
        hold on;
        legend('ominidirectional','120 sec','60 sec')
        figure (2)
        plot(SIR_db,cells_per_custer); 
        ylabel('cells per custer'), xlabel('SIRdb');
        title(['cells per custer Vs. SIRdb(min)']);
        hold on;
        legend('ominidirectional','120 sec','60 sec')
        
end
%%%%%%%%%%%%%%%%%%%%%%%Qusestion 2%%%%%%%%%%%%%%%%%
GOS = 0.01:0.01:0.3; %input('Enter the GOS Value');
city_area = 100; %input('Enter the area of your city');
user_density = 1400 ; %input('Enter the Density');   % user_density: Total number of users (u).
SIR_db = 19; %input('Enter the SIR Value in db');
%sector_method = 120; %input('Enter the sectorization method','s'); % sector_method: sectorization method.
for i=[6,2,1]
        for j=1:length(GOS)
                   SIR_ratio = power(10 , (SIR_db/10) );  %convert from dB
                   cells_per_custer = power( (SIR_ratio * i), (2/n) )/3 ;  %intial value for N
                   N=calc_cluster_size(cells_per_custer); %choose possible number for N
                   C = floor(channels / N) ; %number of channels per cell
                   C_new = floor(C /(6/i));  %number of channels per sector
                   A_sec(j) = ErlangB ( C_new ,GOS(j) );  %intenisty per sector
                   A_cell(j) = A_sec(j) * (6/i);   %intenisty per cell
                   user_cell(j) = A_cell(j) / Au ;     %user_cell: number of users per cell.
                   total_users = user_density * city_area ;   %number of users in total area
                   No_of_cells(j) = total_users / user_cell(j) ;   %number of needed cells
        end
        figure (3)
        plot(GOS*100,A_cell); 
        ylabel('traffic intensity per cell'), xlabel('GOS %');
        title(['traffic intensity per cell versus GOS at SIR=19dB']);
        hold on;
        legend('ominidirectional','120 sec','60 sec')
        figure (4)
        plot(GOS*100,No_of_cells); 
        ylabel('no. of cells'), xlabel('GOS %');
        title(['no. of cells versus GOS at SIR=19dB']);
        hold on;
        legend('ominidirectional','120 sec','60 sec')
        
end
%%%%%%%%%%%%%%%%%%%%%%%Qusestion 3%%%%%%%%%%%%%%%%%
GOS = 0.01:0.01:0.3; %input('Enter the GOS Value');
city_area = 100; %input('Enter the area of your city');
user_density = 1400 ; %input('Enter the Density');   % user_density: Total number of users (u).
SIR_db = 14; %input('Enter the SIR Value in db');
%sector_method = 120; %input('Enter the sectorization method','s'); % sector_method: sectorization method.
for i=[6,2,1]
        for j=1:length(GOS)
                   SIR_ratio = power(10 , (SIR_db/10) );
                   cells_per_custer = power( (SIR_ratio * i), (2/n) )/3 ; 
                   N=calc_cluster_size(cells_per_custer);
                   C = floor(channels / N) ;
                   C_new = floor(C /(6/i));
                   A_sec(j) = ErlangB ( C_new ,GOS(j) );
                   A_cell(j) = A_sec(j) * (6/i);
                   user_cell(j) = A_cell(j) / Au ;     
                   total_users = user_density * city_area ;
                   No_of_cells(j) = total_users / user_cell(j) ;
        end
        figure (5)
        plot(GOS*100,A_cell); 
        ylabel('traffic intensity per cell'), xlabel('GOS %');
        title(['traffic intensity per cell versus GOS at SIR=14dB']);
        hold on;
        legend('ominidirectional','120 sec','60 sec')
        figure (6)
        plot(GOS*100,No_of_cells); 
        ylabel('no. of cells'), xlabel('GOS%');
        title(['no. of cells versus GOS at SIR=14dB']);
        hold on;
        legend('ominidirectional','120 sec','60 sec')
        
end

%%%%%%%%%%%%%%%%%%%%%%%Qusestion 4%%%%%%%%%%%%%%%%%
GOS = 0.02; %input('Enter the GOS Value');
city_area = 100; %input('Enter the area of your city');
user_density = 100:50:2000 ; %input('Enter the Density');   % user_density: Total number of users (u).
SIR_db = 14; %input('Enter the SIR Value in db');
%sector_method = 120; %input('Enter the sectorization method','s'); % sector_method: sectorization method.
for i=[6,2,1]
        for j=1:length(user_density)
                   SIR_ratio = power(10 , (SIR_db/10) );
                   cells_per_custer = power( (SIR_ratio * i), (2/n) )/3 ; 
                   N= calc_cluster_size(cells_per_custer);
                   C = floor(channels / N) ;
                   C_new = floor(C /(6/i));
                   A_sec = ErlangB ( C_new,GOS);
                   A_cell = A_sec * (6/i);
                   user_cell = A_cell / Au ;     
                   total_users(j) = user_density(j) * city_area ;
                   No_of_cells(j) = total_users(j) * (1/user_cell) ;
                   area_cell(j) = city_area / No_of_cells(j) ;  %area of cell
                   cell_radius(j) = sqrt( ((2*area_cell(j))/sqrt(3) ) ) ;   %raduis of the cell
        end
        figure (7)
        plot(user_density,cell_radius); 
        ylabel('cell radius'), xlabel('user_density');
        title(['cell radius versus user density at SIR=14dB']);
        hold on;
        legend('ominidirectional','120 sec','60 sec')
        figure (8)
        plot(user_density,No_of_cells); 
        ylabel('no. of cells'), xlabel('user density');
        title(['no. of cells versus user density at SIR=14dB']);
        hold on;
        legend('ominidirectional','120 sec','60 sec')
        
end

%%%%%%%%%%%%%%%%%%%%%%%Qusestion 5%%%%%%%%%%%%%%%%%
GOS = 0.02; %input('Enter the GOS Value');
city_area = 100; %input('Enter the area of your city');
user_density = 100:50:2000 ; %input('Enter the Density');   % user_density: Total number of users (u).
SIR_db = 19; %input('Enter the SIR Value in db');
%sector_method = 120; %input('Enter the sectorization method','s'); % sector_method: sectorization method.
for i=[6,2,1]
        for j=1:length(user_density)
                   SIR_ratio = power(10 , (SIR_db/10) );
                   cells_per_custer = power( (SIR_ratio * i), (2/n) )/3 ; 
                   N=calc_cluster_size(cells_per_custer);
                   C = floor(channels / N) ;
                   C_new = floor(C /(6/i));
                   A_sec = ErlangB ( C_new,GOS);
                   A_cell = A_sec * (6/i);
                   user_cell = A_cell / Au ;     
                   total_users(j) = user_density(j) * city_area ;
                   No_of_cells(j) = total_users(j) / user_cell ;
                   area_cell(j) = city_area / No_of_cells(j) ;
                   cell_radius(j) = sqrt( ((2*area_cell(j))/sqrt(3) ) ) ;
        end
        figure (9)
        plot(user_density,cell_radius); 
        ylabel('cell radius'), xlabel('user_density');
        title(['cell radius versus user density at SIR=19dB']);
        hold on;
        legend('ominidirectional','120 sec','60 sec')
        figure (10)
        plot(user_density,No_of_cells); 
        ylabel('no. of cells'), xlabel('user_density');
        title(['no. of cells versus user density at SIR=19dB']);
        hold on;
        legend('ominidirectional','120 sec','60 sec')   
        
end