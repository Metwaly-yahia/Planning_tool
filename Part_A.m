clear all
%%%Geegd
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
GOS = input('Enter the GOS Value');
city_area = input('Enter the area of your city');
user_density = input('Enter the Density');   % user_density: Total number of users (u).
SIR_db = input('Enter the SIR Value in db');
sector_method = input('Enter the sectorization method','s'); % sector_method: sectorization method.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SIR_ratio = power(10 , (SIR_db/10) );
if sector_method == 60
   i = 1 ;
   cells_per_custer = power( (SIR_ratio * i), (2/n) )/3 ; 
   N=calc_cluster_size(cells_per_custer);
   C = floor(channels / N) ; %channels per cell
   C_new =floor(C /6);   %channels per sector
   A_sec = ErlangB ( C_new ,GOS );  %traffic intenisty per sector
   A_cell = A_sec * 6;   %traffic intenisty per cell

   
elseif sector_method == 120
    i = 2 ;
    cells_per_custer = power( (SIR_ratio * i), (2/n) )/3 ;
    N=calc_cluster_size(cells_per_custer);
    C = floor(channels / N) ;
    C_new = floor(C /3);
    A_sec = ErlangB ( C_new ,GOS );
    A_cell = A_sec * 3;

    
else
    i = 6 ;
    cells_per_custer = power( (SIR_ratio * i), (2/n) )/3 ; 
    N=calc_cluster_size(cells_per_custer);
    C_new = floor(channels / N) ;
    A_cell = ErlangB ( C_new ,GOS );
end

user_cell = A_cell / Au ;     %user_cell: No. of users per cell.
total_users = user_density * city_area ;  %number of users in total area
No_of_cells = total_users / user_cell ;   %number of needed cells
area_cell = city_area / No_of_cells ;   %area of cell
cell_radius = sqrt( ((2*area_cell)/sqrt(3) ) ) ;   %raduis of the cell
traffic_per_cell = A_cell;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

destace = cell_radius / 1000;
CH = 0.8 + (1.1* log10(frequency) -0.7)* MS_height - 1.56 * log10(frequency);
%Hata model 
pass_loss = 69.55 + 26.16 * log10(frequency) - 13.82 * log10(BS_height) - CH + (44.9 -6.55 * log10(BS_height))* log10(destace);
PTX_dBm = pass_loss + MS_sensitivity_dbm; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

destace_new = 0:0.5:10;
for i =1:length(destace_new)
  %Hata model   
  pass_loss = 69.55 + 26.16 * log10(frequency) - 13.82 * log10(BS_height) - CH + (44.9 -6.55 * log10(BS_height))* log10(destace_new(i));  %Hata model 
  PRX_dBm(i) = PTX_dBm - pass_loss;
end
plot(destace_new,PRX_dBm);
ylabel('PRX (dBm)'), xlabel('d (Km)');
title(['recieved power Vs. distance']);
     



