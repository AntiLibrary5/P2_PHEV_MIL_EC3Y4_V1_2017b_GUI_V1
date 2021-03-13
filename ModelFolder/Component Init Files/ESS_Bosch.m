Atm_temp = 25;
SOC_init = ess.plant.initial_soc;
Cells = 104;
Chg = 31;
H_coef = 3500;
SOC_bp = [0; 0.1; 0.2; 0.3; 0.4; 0.5; 0.6; 0.7; 0.8; 0.9; 1];
Em = [1.5; 3.519; 3.606; 3.684; 3.754; 3.829; 3.888; 3.968; 4.034; 4.085; 4.181];
%Validated
%Em = [1.50000000000000;2.64973108451630;3.50000000000000;3.66000000000000;3.71489659942551;3.76076782405973;3.81802878007327;3.92421449664825;4.02068952114054;4.11516880847363;4.18153354268722];
R_0 = [0.000800000000000000,0.000800000000000000,0.000800000000000000;0.000800000000000000,0.00196391794671400,0.00979213304529639;0.000800000000000000,0.00183803320390000,0.000100000000000022;0.000800000000000000,0.00172168962591609,0.000102643779955440;0.000800000000000000,0.00145626646501328,0.00235468890909303;0.000800000000000000,0.00144683693658519,0.00172519225520489;0.000800000000000000,0.00138318739717377,0.00210631748754483;0.000800000000000000,0.00132116235238717,0.00245116621610260;0.000800000000000000,0.00136354747726760,0.00335888070210369;0.000800000000000000,0.00122905990082319,0.00593497595310220;0.000800000000000000,0.00207890132834094,0.00145587356901100];
R_1 = [0.000500000000000000,0.000500000000000000,0.000500000000000000;0.000500000000000000,0.000542502270391231,0.000509937902422004;0.000500000000000000,0.000572575084732444,0.000498031194113220;0.000500000000000000,0.000527499198883568,0.000497833780156020;0.000500000000000000,0.000523753342574450,0.000503265982764169;0.000500000000000000,0.000529553919552448,0.000503767555419085;0.000500000000000000,0.000529680810769354,0.000504597259456957;0.000500000000000000,0.000512804750460074,0.000501972340807806;0.000500000000000000,0.000490984918903131,0.000499898091974676;0.000500000000000000,0.000510678363987715,0.000503511946870526;0.000500000000000000,0.000501266487222077,0.000500287939780328];
T_bp = [273 298 323];
I_loss = 0.11;

%%

% THis is the ESS Initialization file. 
% It loads all the ESS specs necessary 
% for the simulation

% ess.plant.init.max_soc = 21;
% ess.plant.init.min_soc = 20;
% ess.plant.init.initial_soc = 9;

battery_desc='Bosch ESS 104S1P ';      
tmax = 100;
%t_amb = 25;
tmin = 0;
ess.Lolimit = 0.0025;

%ess.plant.init.initial_soc = 100;
ess.plant.init.module_added_mass=5.2;           %Packaging Per module (kg)
ess.plant.init.modules=8;                       %Modules in Series

ess.plant.init.Nominal_Voltage=3.68;            % Cell Nominal voltage in V, @ C/3
ess.plant.init.parallel_cells=1;                % number of parallel strings per pack
ess.plant.init.series_cells=13*ess.plant.init.modules;                % number of series Modules in Pack
ess.plant.init.cell_mass=0.734;                 % Cell Mass [kg]
ess.plant.init.cell_min_V=2.8;                  % Min Cell OCV
ess.plant.init.cell_max_V=4.135;                % Max Cell OCV 
ess.plant.init.cell_cap_Ah=24.9;                % Cell capacity 
ess.plant.init.batcap = ess.plant.init.parallel_cells*ess.plant.init.cell_cap_Ah; %amps/hr
ess.plant.init.Peukert_exp=1.024;

% Index of battery soc
ess.plant.init.bat_soc_idx=[5 10 15 20 25 30 40 50 60 70 80 90 95 100]/100; 
% OCV for Pack 
ess.plant.init.bat_voc=[3.089 3.197 3.212 3.231 3.248 3.259 3.290 3.291 3.293 3.301 3.333 3.335 3.338 3.432]*ess.plant.init.series_cells;	  	     
% Pack charge resistance, ohms from HPPC test
ess.plant.init.bat_r_chg=...
    [.003191 .002527 .002106 .002120 .002113 .002082 .002033 .002002 .001982 .002011 .001974 .001983 .002016 .002016]...
    *ess.plant.init.series_cells/ess.plant.init.parallel_cells;
    % Pack discharge resistance, ohms from HPPC test
ess.plant.init.bat_r_dis=...
    [.003342 .002340 .002161 .002078 .001999 .001982 .001898 .001839 .001789 .001789 .001784 .001736 .001705 .002171]...
    *ess.plant.init.series_cells/ess.plant.init.parallel_cells;
    
ess.plant.init.batpk_vnom=ess.plant.init.Nominal_Voltage*ess.plant.init.series_cells;                             %Battery nominal voltage

%Battery mass
ess.plant.init.bat_mass=150;     %Pack mass [kg]
%ess.plant.init.bat_mass=...
    ess.plant.init.series_cells*ess.plant.init.parallel_cells*ess.plant.init.cell_mass+...
    ess.plant.init.modules*ess.plant.init.module_added_mass; %All modules overall mass (kg)
ess.plant.init.bat_overall_mass=1.1*ess.plant.init.bat_mass;  % 10% added weight for packaging

%Battery Limits
ess.plant.init.limit.idx1_soc=[0 10 20 30 40 50 60 70 80 90 100]; % changed ess.plant.init.limit.idx1_soc
ess.plant.init.limit.idx2_temp=[-30 -20 -10 0 20 40 50 60];   % changed ess.plant.init.limit.idx2_temp
%10s Discharge peak per SOC & temp
ess.plant.init.max_discharge_limit=[0     42.4   59.7   65.4  69.6  75.6  81.8  83.9  86.0  91.8  115.8; % changed ess.plant.init.max_discharge_limit
                                    0     113.5  130.5  144.5 155.7 163.4 170.8 173.9 176.8 186.9 216.7 ;
                                    0     184.4  250.9  275.2 293.6 302.6 310.8 316.4 321.7 339.9 391.9 ;
                                    0     300.5  456.0  489.6 509.9 521.8 532.1 544.9 557.2 585.1 612   ;
                                    0     540    612    612   612   612   612   612   612   612   612   ;
                                    0     540    612    612   612   612   612   612   612   612   612   ;
                                    0     612    612    612   612   612   612   612   612   612   612   ;
                                    0     0      0      0     0     0     0     0     0     0     0     ]';
%Discharge Cont. per  SOC & temp 
ess.plant.init.max_cont_discharge=[0    30   55.3 60   60   60   60   60   60   60   60   ;   % changed ess.plant.init.max_cont_discharge
                                   0    37.7 94.3 94.3 94.3 94.3 94.3 94.3 94.3 94.3 94.3 ;
                                   0    164  180  180  180  180  180  180  180  180  180  ;
                                   0    180  180  180  180  180  180  180  180  180  180  ;
                                   0    180  180  180  180  180  180  180  180  180  180  ;
                                   0    180  180  180  180  180  180  180  180  180  180  ;
                                   0    180  180  180  180  180  180  180  180  180  180  ;
                                   0    0    0    0    0    0    0    0    0    0    0    ]';
%10s Charge peak per  SOC & temp
ess.plant.init.max_charge_limit=[0     0     0     0      0     0     0     0     0     0     0;  % changed ess.plant.init.max_charge_limit
                                 30    30    30    30     60    65.2  61.8  59.9  58.2  55.1  0;
                                 234.6 188.3 168.1 160.5  156.3 148   140.9 136.6 132.8 126.6 0;
                                 300   300   286   266.1  251.7 239.9 230.1 220.6 211.9 204.4 0;
                                 300   300   300   300    300   300   300   300   300   294.8 0;
                                 300   300   300   300    300   300   300   300   300   300   0; 
                                 300   300   300   300    300   300   300   300   300   300   0;
                                 0     0     0     0      0     0     0     0     0     0     0]';
%Charge Cont. per  SOC & temp
ess.plant.init.max_cont_charge=[0    0    0    0    0    0    0    0    0    0    0; % changed ess.plant.init.max_cont_charge
                                6    6    6    6    6    6    6    6    6    6    0;
                                19.8 19.8 19.8 19.8 19.8 19.8 19.8 19.8 19.8 19.8 0;
                                30   30   30   30   30   30   30   30   30   30   0;
                                60   60   60   60   60   60   60   60   60   60   0;
                                60   60   60   60   60   60   60   60   60   60   0; 
                                60   60   60   60   60   60   60   60   60   60   0;
                                 0   0    0    0    0    0    0    0    0    0    0]';
    
ess.plant.init.specific_heat=  1670;          %J/Kg/k
ess.plant.init.idx_WEGPmp_DtyCyc=[0 1 1.1 8 8.1 12.9 13 86 98 98.1 100];%[%]
ess.plant.init.WEGPmp.map=[0 0 0.49 0.49 0 0 0.05 0.5 0.5 0.49 0.49]*1000; %W


% pack description
batpk_desc=...
    [battery_desc ' ' num2str(ess.plant.init.batpk_vnom...
                    *ess.plant.init.batcap/1000) ' kWh' ...
     ', ' num2str(ess.plant.init.series_cells) 'x' ...
                    num2str(ess.plant.init.parallel_cells) ' units '... 
     ', Nominal Voltage ' num2str(ess.plant.init.batpk_vnom) 'V' ...
     ', ' num2str(ess.plant.init.bat_overall_mass) 'kg'];

disp(['Battery: ' batpk_desc]);
Tamb = 25;
mph2kph = 1.60934;
WORKSPACE_DECIMATION = 10;
%Battery inlet air temp in Celsius
bms_inletair_temp = 25;
bms_maxchargecurrent = 180; %in A
bms_maxdischargecurrent = 315; %in A
BMS_Notfallkuehlung = 0;
bms_temp_limit = 55;





