%% File description
% Name : eng_si_2400_133_LEA_E85_ecocar3.m
% Author : Ram V.Gopal (ANL)
% Description : Initialize the 2.4L E85 LEA GM Engine used in ecocar3
% Proprietary : ecocar3
% Model : lib_eng_map_hot
% Technology : si
% Vehicle Type : Light


%% File content
eng.plant.init.technology                   = 'si';
eng.plant.init.num_cyl_init                 = 4;
eng.plant.init.num_cyl_banks                = 1;
eng.plant.init.material                     = 'Aluminum'; %Assumption
eng.plant.init.cyl_config                   ='inline';
eng.plant.init.cam_shaft_config             ='dohc';
eng.plant.init.has_cyl_deac                 = true;
eng.plant.init.has_variable_valve_lift      = false;
eng.plant.init.has_variable_valve_timing    = true;
eng.plant.init.has_hcci                     = false;
eng.plant.init.has_direct_injec             = false;
eng.plant.init.has_boost                    = false;%Assumption

eng.plant.init.fuel_density_val           = 0.801;          % kg/L
eng.plant.init.fuel_heating_val      	    = 29047000;    % (J/kg)Specific LHV
eng.plant.init.fuel_carbon_ratio  	    = 0.8696;      % (kg/kg) ref:Dr. Rob Thring

eng.plant.init.mass.eng                   = 140;%estimated eng.plant.init.mass_block + eng.plant.init.mass_radiator + eng.plant.init.mass_vol + eng.plant.init.mass.tank;
eng.plant.init.mass.tank                  = 20;
eng.plant.init.mass.fuel                  = conversion_calc('volume','gallon','l',15)*eng.plant.init.fuel_density_val;%Capacity of tank in kg - approximate value
	
eng.plant.init.time_response              = 0.3; 						
eng.plant.init.spd_idle		 			= 62;%rad/s
eng.plant.init.warmup_init				= 0;							% This should normally by 0
eng.plant.init.pwr_max				    = 113642;					% Watts
eng.plant.init.ex_gas_heat_cap            = 1089;            % J/kgK  ave sens heat cap of exh gas (SAE #890798)

eng.plant.init.displ_init					= 2400;		% cc
eng.plant.init.inertia					= 0.1	;		% kg-m^2 - approximate value
eng.plant.init.spd_str					= 10; % speed level (rad/s) the engine crank has to reach in order to start 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% maximum curves at each speed (closed and wide open throttle)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% hot max wide open throttle curves
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eng.plant.init.trq_max_hot.idx1_spd= conversion_calc('rotational_speed','rpm','rad/s',[...
   600.00     800.00     1000.00     1200.00     1400.00     1600.00     1800.00     2000.00     2200.00     2400.00     2600.00     2800.00     3000.00     3200.00     3400.00     3600.00     3800.00     4000.00     4250.00     4500.00     4750.00     5000.00     5250.00     5500.00     5750.00     6000.00     6250.00     6500.00  ...
]);
eng.plant.init.trq_max_hot.map= [...
   83.79     136.76     95.68     152.01     171.59     185.90     198.40     197.36     200.55     202.26     215.08     204.81     204.52     208.10     211.52     210.56     214.10     213.47     208.73     208.43     208.67     231.21     228.31     225.33     220.52     211.21     204.19     151.77  ...
];

% Mid speed is used in logic to limit closed and wide open torque curves
eng.plant.init.spd_avg	= 0.5 * (eng.plant.init.trq_max_hot.idx1_spd(1) + eng.plant.init.trq_max_hot.idx1_spd(length(eng.plant.init.trq_max_hot.idx1_spd)));
      
% % hot max closed throttle curves
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eng.plant.init.trq_min_hot.idx1_spd 	= eng.plant.init.trq_max_hot.idx1_spd;
% eng.plant.init.trq_min_hot.map = [0 -5*ones(1,size(eng.plant.init.trq_max_hot.idx1_spd,2)-1)];
%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% consumption table
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

eng.plant.init.fuel_hot.idx1_spd	= conversion_calc('rotational_speed','rpm','rad/s',[...
   600.00     800.00     1000.00     1200.00     1400.00     1600.00     1800.00     2000.00     2200.00     2400.00     2600.00     2800.00     3000.00     3200.00     3400.00     3600.00     3800.00     4000.00     4250.00     4500.00     4750.00     5000.00     5250.00     5500.00     5750.00     6000.00     6250.00     6500.00  ...
]);
eng.plant.init.fuel_hot.idx2_trq = [...
   0.00     13.59     27.18     40.77     54.36     67.95     81.53     95.12     108.71     122.30     135.89     149.48     163.07     176.66     190.25     203.84     217.42     231.01  ...
];

% Rows represent speed (rad/s).  Columns represent torque (N-m).  Table is fuel rate (kg/s)
eng.plant.init.fuel_hot.map = (1/1000)*[...
   0.111561     0.196554     0.277328     0.350750     0.427550     0.504350     0.581150     0.657950     0.734750     0.811549     0.888349     0.965149     1.041949     1.118749     1.195549     1.272348     1.349148     1.425948  ;...
   0.204020     0.259656     0.344023     0.432285     0.524367     0.617086     0.709805     0.802524     0.891326     1.037483     1.237965     1.438447     1.638929     1.839411     2.039893     2.240375     2.440857     2.641339  ;...
   0.255721     0.321391     0.425657     0.525298     0.630821     0.742574     0.846812     0.954516     1.063909     1.173302     1.282695     1.392088     1.501481     1.610874     1.720267     1.829660     1.939052     2.048445  ;...
   0.256868     0.386711     0.509726     0.632720     0.757158     0.888480     1.020928     1.149898     1.281049     1.409894     1.539150     1.678707     1.818264     1.957821     2.097377     2.236934     2.376491     2.516048  ;...
   0.336073     0.467691     0.599308     0.736482     0.874993     1.031254     1.186454     1.342826     1.496539     1.649163     1.803843     1.968158     2.139417     2.312242     2.485067     2.657892     2.830717     3.003542  ;...
   0.393587     0.536655     0.691167     0.851454     1.023407     1.196286     1.372684     1.547990     1.729892     1.901901     2.070398     2.246747     2.434598     2.624707     2.816983     3.009852     3.202721     3.395591  ;...
   0.463408     0.617584     0.801445     0.986808     1.180715     1.376886     1.567637     1.760194     1.961928     2.156125     2.347026     2.541206     2.734039     2.933263     3.141837     3.352093     3.562348     3.772604  ;...
   0.514059     0.689795     0.888266     1.093257     1.315834     1.534841     1.746877     1.958872     2.183999     2.404464     2.622082     2.839261     3.046168     3.261528     3.490624     3.721901     3.953179     4.184456  ;...
   0.536253     0.771796     0.991286     1.219464     1.447425     1.675050     1.928549     2.155079     2.400028     2.646718     2.895030     3.145258     3.376325     3.614604     3.865655     4.102309     4.338962     4.575616  ;...
   0.682884     0.868087     1.102413     1.338036     1.587788     1.829229     2.085159     2.350387     2.609646     2.875116     3.147136     3.428942     3.699919     3.969004     4.239187     4.519488     4.799788     5.080088  ;...
   0.760697     0.939323     1.189074     1.452905     1.719248     1.993508     2.272309     2.565403     2.841111     3.121754     3.405727     3.690339     3.985839     4.297051     4.625980     4.944307     6.271004     8.293142  ;...
   0.819583     1.030166     1.292377     1.567309     1.856344     2.157025     2.452743     2.778521     3.080475     3.391090     3.702061     3.996761     4.285446     4.614030     4.993035     5.404293     5.815550     6.226808  ;...
   0.902825     1.119079     1.396907     1.686811     2.005055     2.335843     2.656718     3.001081     3.324951     3.651052     3.974445     4.281496     4.596375     4.969997     5.421003     5.872253     6.323504     6.774754  ;...
   0.951324     1.191668     1.490191     1.801372     2.150167     2.506891     2.850891     3.215675     3.559940     3.909061     4.257070     4.587623     4.952612     5.352956     5.799453     6.341390     7.829007     9.442382  ;...
   1.033028     1.300277     1.619087     1.948641     2.323667     2.705918     3.061442     3.459519     3.823254     4.193314     4.560635     4.905293     5.312088     5.751741     6.220311     6.812198     7.980956     9.471409  ;...
   1.104700     1.393942     1.740250     2.099281     2.484675     2.895696     3.276562     3.698101     4.085814     4.477767     4.866161     5.234726     5.708690     6.252734     6.809804     7.240347     8.344894     9.700218  ;...
   1.209651     1.494361     1.887591     2.281779     2.681553     3.104616     3.496473     3.934731     4.358463     4.792459     5.225320     5.625857     6.140940     6.874716     7.853466     8.484636     9.599840     10.868147  ;...
   1.287306     1.607312     2.027653     2.447512     2.871702     3.319411     3.736638     4.195479     4.664378     5.129699     5.578726     5.981761     6.649871     7.454910     8.354385     9.081362     10.652458     12.874186  ;...
   1.396289     1.743422     2.184699     2.630917     3.092302     3.554836     3.978667     4.444411     4.976691     5.483121     5.967735     6.430493     7.348974     8.193695     8.820732     9.590512     10.360291     11.130071  ;...
   1.533396     1.901653     2.374888     2.832383     3.314976     3.833497     4.282101     4.795021     5.359770     6.023528     6.722855     7.245261     7.875044     8.470489     8.980078     9.867818     10.755559     11.643299  ;...
   1.652740     2.068080     2.558527     3.036479     3.562233     4.078207     4.580973     5.179219     5.782916     6.390202     6.988615     7.539433     8.152745     8.746518     9.303539     10.072870     10.842201     11.611532  ;...
   1.795846     2.229853     2.744557     3.260422     3.796113     4.331163     4.895684     5.572582     6.230425     6.908633     7.583812     8.202671     8.809149     9.401730     9.991220     10.753136     11.617294     12.673701  ;...
   1.937161     2.372656     2.936123     3.492404     4.080529     4.615173     5.229663     5.951735     6.650245     7.375550     8.103075     8.772274     9.388697     10.028478     10.722412     11.475226     12.383666     13.642897  ;...
   2.045613     2.545274     3.138476     3.761761     4.347811     4.903689     5.612662     6.399633     7.141735     7.875504     8.705927     9.383420     10.068144     10.877168     11.839177     12.656650     13.681334     14.818275  ;...
   2.237452     2.781856     3.406719     4.032522     4.653070     5.261690     6.086901     6.834373     7.622478     8.400702     9.183175     10.006299     10.764848     11.712357     12.875877     13.719988     14.756363     15.903427  ;...
   2.371062     2.981016     3.666583     4.338050     4.984053     5.650226     6.616531     7.509106     8.372018     9.278849     10.230811     11.242227     12.130831     13.355332     14.977822     15.877525     18.430425     21.923075  ;...
   2.618621     3.280376     3.987869     4.695038     5.361601     6.060297     7.126461     8.097172     8.991260     9.944470     10.934253     11.911747     12.866721     14.189213     15.950110     16.877376     17.804642     18.731908  ;...
   2.879918     3.563816     4.277832     5.047601     5.739076     6.477651     7.631644     8.635966     9.870557     10.996473     12.092350     13.329266     14.566182     15.803098     17.040014     18.276930     19.513846     20.750762];%in kg/s

% locate the minimum torque with fuel based on Willans lines

for i = 1:1:length(eng.plant.init.fuel_hot.idx1_spd)
    pp = spline(eng.plant.init.fuel_hot.map(i,:),eng.plant.init.fuel_hot.idx2_trq);
    eng.temp.plant.init.trq_min_hot.map(i) = ppval(pp,0.5/10000); 
end

pp1 = spline(eng.plant.init.fuel_hot.idx1_spd,eng.temp.plant.init.trq_min_hot.map);

for i=1:1:length(eng.plant.init.trq_max_hot.idx1_spd)
    eng.plant.init.trq_min_hot.map(i) = ppval(pp1,eng.plant.init.trq_max_hot.idx1_spd(i));
end

eng.plant.init.trq_min_hot.idx1_spd = eng.plant.init.trq_max_hot.idx1_spd;

clear pp pp1 ;


% Expand the map to the minimum torque with fuel curve

eng.temp.plant.init.trq_step = eng.plant.init.fuel_hot.idx2_trq(2)-eng.plant.init.fuel_hot.idx2_trq(1);
eng.temp.plant.init.trq_first_idx = eng.plant.init.fuel_hot.idx2_trq(1) - eng.temp.plant.init.trq_step;
temp_negative_torque_index = [eng.temp.plant.init.trq_first_idx:-eng.temp.plant.init.trq_step: min(eng.plant.init.trq_min_hot.map)];


temp_map = zeros(length(eng.plant.init.fuel_hot.idx1_spd),length(temp_negative_torque_index));
for i = 1:1:length(eng.plant.init.fuel_hot.idx1_spd)
    temp1_map(i,:)= [0 eng.plant.init.fuel_hot.map(i,:)];
end

for i =1:1:length(eng.plant.init.fuel_hot.idx2_trq)
    temp_trq_index(i)= eng.plant.init.fuel_hot.idx2_trq(end-i+1);
end

for i=1:1:length(eng.plant.init.fuel_hot.idx1_spd)
    for j = 1:1:length(eng.plant.init.fuel_hot.idx2_trq)
        temp2_map(i,j)= eng.plant.init.fuel_hot.map(i,end-j+1);
    end
end

for i=1:1:length(eng.plant.init.fuel_hot.idx1_spd)
      
    fuel_vector = interp1([temp_trq_index eng.plant.init.trq_min_hot.map(i)],[temp2_map(i,:) temp1_map(i,1)],[eng.temp.plant.init.trq_first_idx:-eng.temp.plant.init.trq_step:eng.plant.init.trq_min_hot.map(i)],'pchip');
    length_fuel_vector = length(fuel_vector);
    temp_map(i,:) = [fuel_vector zeros(1,length(temp_negative_torque_index)-length(fuel_vector))];
    clear fuel_vector;
end

eng.plant.init.fuel_hot.idx2_trq = [temp_negative_torque_index(end):eng.temp.plant.init.trq_step:temp_negative_torque_index(1) eng.plant.init.fuel_hot.idx2_trq];

for i = 1:1: length(eng.plant.init.fuel_hot.idx1_spd)
    for j=1:1:length(temp_map(i,:))
        temp3_map(i,j) = temp_map(i,end+1-j);
    end
end

eng.plant.init.fuel_hot.map = [temp3_map eng.plant.init.fuel_hot.map];

eng.plant.init.trq_zero_fuel_hot.idx1_spd = eng.plant.init.trq_max_hot.idx1_spd;
eng.plant.init.trq_zero_fuel_hot.map            = zeros(1,length(eng.plant.init.trq_max_hot.idx1_spd));

clear temp_negative_torque_index temp_map temp1_map length_fuel_vector temp2_map i j fuel_rate_at_500_rpm temp_trq_index temp2_map temp3_map

%Emissions in percentage of fuel rate (kg/s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eng.plant.init.co_hot.idx1_spd = eng.plant.init.fuel_hot.idx1_spd;
eng.plant.init.co_hot.idx2_trq = eng.plant.init.fuel_hot.idx2_trq;
eng.plant.init.co_hot.map       = zeros(length(eng.plant.init.co_hot.idx1_spd),length(eng.plant.init.co_hot.idx2_trq)); 

eng.plant.init.hc_hot.idx1_spd = eng.plant.init.fuel_hot.idx1_spd;
eng.plant.init.hc_hot.idx2_trq = eng.plant.init.fuel_hot.idx2_trq;
eng.plant.init.hc_hot.map       = zeros(length(eng.plant.init.hc_hot.idx1_spd),length(eng.plant.init.hc_hot.idx2_trq));

eng.plant.init.nox_hot.idx1_spd = eng.plant.init.fuel_hot.idx1_spd;
eng.plant.init.nox_hot.idx2_trq = eng.plant.init.fuel_hot.idx2_trq;
eng.plant.init.nox_hot.map       = zeros(length(eng.plant.init.nox_hot.idx1_spd),length(eng.plant.init.nox_hot.idx2_trq));

eng.plant.init.pm_hot.idx1_spd = eng.plant.init.fuel_hot.idx1_spd;
eng.plant.init.pm_hot.idx2_trq = eng.plant.init.fuel_hot.idx2_trq;
eng.plant.init.pm_hot.map       = zeros(length(eng.plant.init.hc_hot.idx1_spd), length(eng.plant.init.nox_hot.idx2_trq));

% O2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eng.plant.init.o2_hot.idx1_spd = eng.plant.init.fuel_hot.idx1_spd;
eng.plant.init.o2_hot.idx2_trq = eng.plant.init.fuel_hot.idx2_trq;
eng.plant.init.o2_hot.map       = zeros(length(eng.plant.init.fuel_hot.idx1_spd),length(eng.plant.init.fuel_hot.idx2_trq));

% exhaust table
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eng.plant.init.equiv_hot.idx1_spd = eng.plant.init.fuel_hot.idx1_spd;
eng.plant.init.equiv_hot.idx2_trq = eng.plant.init.fuel_hot.idx2_trq;
eng.plant.init.equiv_hot.map       =  ones(length(eng.plant.init.equiv_hot.idx1_spd),length(eng.plant.init.equiv_hot.idx2_trq));

% Heat rejection variable Presid data table
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eng.plant.init.htrej_hot.idx1_spd = eng.plant.init.fuel_hot.idx1_spd;
eng.plant.init.htrej_hot.idx2_trq = eng.plant.init.fuel_hot.idx2_trq;
eng.plant.init.htrej_hot.map       = zeros(length(eng.plant.init.fuel_hot.idx1_spd),length(eng.plant.init.fuel_hot.idx2_trq));

% Heat Transfer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
eng.plant.init.ex_gas_flow_hot.idx1_spd =   eng.plant.init.fuel_hot.idx1_spd;
eng.plant.init.ex_gas_flow_hot.idx2_trq =   eng.plant.init.fuel_hot.idx2_trq;
eng.plant.init.ex_gas_flow_hot.map       =   eng.plant.init.fuel_hot.map *(1+20);                  % g/s  ex gas flow map:  for CI engines, exflow=(fuel use)*[1 + (ave A/F ratio)]

%eng.plant.init.v0x\fuel use, thermal and emissions\thermal\fc heat net calculation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eng.plant.init.ex_pwr.map = eng.plant.init.fuel_hot.idx1_spd'*eng.plant.init.fuel_hot.idx2_trq;
eng.plant.init.ex_temp.map = eng.plant.init.ex_pwr.map./(eng.plant.init.ex_gas_flow_hot.map *1089) + 20;  % W   EO ex gas temp = Q/(MF*cp) + Tamb (assumes engine tested ~20 C)
eng.plant.init.ex_temp.idx1_spd = eng.plant.init.fuel_hot.idx1_spd; 
eng.plant.init.ex_temp.idx2_trq = eng.plant.init.fuel_hot.idx2_trq;
eng.plant.init.temp_operating = 90;
eng.plant.init.ex_temp_operating = mean(mean(eng.plant.init.ex_temp.map));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calculations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% maximum and minimum calculations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eng.plant.init.trq_max_hot.trq_max	= max(eng.plant.init.trq_max_hot.map); % N-m
[eng.plant.init.pwr_max_hot.pwr_max,Idx]  = max(eng.plant.init.trq_max_hot.idx1_spd.* eng.plant.init.trq_max_hot.map); % W
eng.plant.init.pwr_max_hot.map = eng.plant.init.trq_max_hot.idx1_spd.* eng.plant.init.trq_max_hot.map; % W

%Code to compute maximum speed of the engine. Speed at 80% of peak power.
eng.plant.init.spd_max =   eng.plant.init.trq_max_hot.idx1_spd(Idx);
if Idx < length(eng.plant.init.pwr_max_hot.map)
    eng.plant.init.spd_max = min(interp1(eng.plant.init.pwr_max_hot.map(Idx:end)+1e-6*(1:length(eng.plant.init.pwr_max_hot.map(Idx:end))),eng.plant.init.trq_max_hot.idx1_spd(Idx:end),eng.plant.init.pwr_max_hot.pwr_max * 0.80,'linear','extrap'),max(eng.plant.init.trq_max_hot.idx1_spd));
end

% Calculate the max engine efficiency in within the max torque curve
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eng.plant.init.eff_hot_pwr.map    = eng.plant.init.fuel_hot.idx1_spd'*eng.plant.init.fuel_hot.idx2_trq/eng.plant.init.fuel_heating_val./(eng.plant.init.fuel_hot.map);
eng.tmp.max_trq         = interp1(eng.plant.init.trq_max_hot.idx1_spd,eng.plant.init.trq_max_hot.map,eng.plant.init.fuel_hot.idx1_spd);
eng.tmp.max_trq         = eng.tmp.max_trq(:)*ones(1,length(eng.plant.init.fuel_hot.idx2_trq));
eng.tmp.max_trq         = (eng.plant.init.fuel_hot.idx2_trq(:) * ones(1,length(eng.plant.init.fuel_hot.idx1_spd)))' > eng.tmp.max_trq;
eng.plant.init.eff_hot_pwr.map(eng.tmp.max_trq) = 0;
eng.plant.init.eff_max        = max(max(eng.plant.init.eff_hot_pwr.map));


%GASOLINE ENGINE zero fuel friction losses 

%some explanation - total losses are called
%'trq_zero_fuel_total_friction' or
%'mep_zero_fuel_total_friction'.

% total friction is made of two parts - 
% Part 1 
   %non pumping losses ( indepdent of
   % throttle position, function of speed only) , given by
   %mep_zero_fuel_non_pumping 

% and
% Part 2 - pumping losses , given by total_zero_fuel_pumping_friction_mep
% pumping losses have two sub categories 
   % Part 2a - throttle related losses given by mep_zero_fuel_throttle_pumping
   % which vary with throttle and speed ( look up table)
% and 
   % Part 2b - valve related losses given by mep_zero_fuel_valve_pumping
   % which also varies with speed and throttle position



% Engine pumping losses when fuel cut -off ; function of throttle and speed
eng.plant.init.mep_zero_fuel_throttle_pumping.idx1_spd = [100 200 300 400 500 600];
eng.plant.init.mep_zero_fuel_throttle_pumping.idx2_throttle = [0:5:55];

% Pumping throttling  mep from steady state data of the 2.2 L engine , with intake and
% exhaust pressure  measured in psia. Data file: 2008-11_24_isobut20 with
% no EGR

eng.plant.init.mep_zero_fuel_throttle_pumping.map = [...
   13.9408   10.4203    7.3257    4.6568    2.4139    0.5967    0.5967    0.5967    0.5967    0.5967    0.5967    0.5967;...
   16.7960   13.2012   10.0322    7.2891    4.9719    3.0804    1.6148    0.5750    0.5750    0.5750    0.5750    0.5750;...
   18.9311   15.2620   12.0188    9.2014    6.8098    4.8441    3.3042    2.1901    1.5019    1.2395    1.4029    1.9921;...
   20.3462   16.6029   13.2854   10.3937    7.9278    5.8878    4.2736    3.0852    2.3227    1.9860    2.0751    2.5901;...
   21.0413   17.2237   13.8319   10.8659    8.3258    6.2115    4.5230    3.2603    2.4235    2.0125    2.0274    2.4680;...
   21.0164   17.1245   13.6584   10.6182    8.0037    5.8151    4.0523    2.7154    1.8043    1.3190    1.2596    1.6260].*6.89475; % psi to kpa

% End of throttle pumping mep calculation

% pumping valve flow mep calculation Step 1 - Using intake manifold pressure (imep) from 2008-11-24_isobut20.imepc stands for
% imep-cold; 
%imep-cold is calculated from  imep Using equation 13.8 from Heywood page 727
% 

eng.plant.init.imepc_zero_fuel_valve_pumping.idx1_spd = eng.plant.init.mep_zero_fuel_throttle_pumping.idx1_spd ;
eng.plant.init.imepc_zero_fuel_valve_pumping.idx2_throttle = eng.plant.init.mep_zero_fuel_throttle_pumping.idx2_throttle;


eng.plant.init.imepc_zero_fuel_valve_pumping.map = [...
    0.009   0.009   0.0175   0.0370   0.0494   0.0547   0.0547   0.0547   0.0547   0.0547   0.0547   0.0547;
    0.007   0.0109  0.0522   0.0865  0.1137   0.1338   0.1469   0.1529   0.1529   0.1529   0.1529    0.1529;
    0.03    0.0466  0.1028   0.1519  0.1939   0.2288   0.2575   0.2913   0.2980   0.2977   0.3069    0.3069;
    0.05    0.0988  0.1692   0.2331  0.2900   0.3397   0.3824   0.4181   0.4467   0.4682   0.4826    0.4900;
    0.0730  0.1659  0.2516   0.3303  0.4020   0.4665   0.5241   0.5745   0.6179   0.6542   0.6835    0.7057;
    0.1417  0.2943  0.3449   0.4434  0.5299   0.6092   0.6816   0.7468   0.8051   0.8562   0.9003    0.9373];


% pumping valve flow mep calculation Step 2 - Calculation of intake valve diameter based on cylinder volume and number
% of engine cylinders.
% Assumptions - bore to stroke (b/s) ratio for I-4 engines is 0.925 and V engines
% is 1.07 [ both Heywood, et.al SAE paper # 2009-01-1892] ; so knowing
% volume per cylinder and b/s ratio, solve for bore (b).
% Also , from page 171, Figure 7-11 of book - Colin R Fergusson,
% Kirkpatrick,'Internal Combustion engines' , intake valve diameter for 2
% intake valves is 0.33*bore, and 0.47 * bore for single intake valve.

eng_intake_valve_dia_in_mm = (0.33 * ((eng.plant.init.displ_init/eng.plant.init.num_cyl_init)/0.8496)^1/3)*1000;

eng_num_intake_valve_per_cylinder =2;

% pumping valve flow mep calculation step 3 - then , using equation 14 from SAE paper # 840807 ( Heywood equation
% 13.13) with 'F' calculated from equation 12 , SAE paper#840807 ( Heywood
% equation 13.13)

F = (eng_num_intake_valve_per_cylinder * (eng_intake_valve_dia_in_mm*0.03937)^2 *eng.plant.init.num_cyl_init)./(eng.plant.init.displ_init *0.0610);

eng.plant.init.mep_zero_fuel_valve_pumping.idx1_spd = eng.plant.init.imepc_zero_fuel_valve_pumping.idx1_spd;
eng.plant.init.mep_zero_fuel_valve_pumping.idx2_throttle = eng.plant.init.imepc_zero_fuel_valve_pumping.idx2_throttle;
eng.plant.init.mep_zero_fuel_valve_pumping.map = eng.plant.init.imepc_zero_fuel_valve_pumping.map./F^1.28;


eng.plant.init.mep_zero_fuel_valve_pumping.map = eng.plant.init.mep_zero_fuel_valve_pumping.map.*6.89475; % psi to kpa

% End of valve pumping mep calculation.

eng.plant.init.mep_zero_fuel_pumping.idx1_spd = eng.plant.init.mep_zero_fuel_valve_pumping.idx1_spd;
eng.plant.init.mep_zero_fuel_pumping.idx2_throttle = eng.plant.init.mep_zero_fuel_valve_pumping.idx2_throttle;
eng.plant.init.mep_zero_fuel_pumping.map = -(eng.plant.init.mep_zero_fuel_throttle_pumping.map + eng.plant.init.mep_zero_fuel_valve_pumping.map);

% End of total ( valve + throtle) pumping mep calculation


% Non - pumping Friction Torque for a 1.7 L Engine Based on Heywood. "Internal Combustion Fundamentals,"
% Section 13.6.1 Figure 13-14 (a) P726 
%Code for fmep (non pumping) calculation Gasoline

eng.plant.init.mep_zero_fuel_non_pumping.idx1_spd =(100:100:600);
eng.plant.init.mep_zero_fuel_non_pumping.map =  polyval([4.2337e-4  -3.41045e-3 62.831],(100:100:max(eng.plant.init.mep_zero_fuel_non_pumping.idx1_spd)));

% end of non pumping mep calculation
% begin adding non pumping and pumping mep to form total frictional mep 
eng.plant.init.mep_zero_fuel_total_friction.idx1_spd = eng.plant.init.mep_zero_fuel_pumping.idx1_spd;
eng.plant.init.mep_zero_fuel_total_friction.idx1_throttle = eng.plant.init.mep_zero_fuel_pumping.idx2_throttle;
eng.plant.init.mep_zero_fuel_total_friction.map = zeros(size(eng.plant.init.mep_zero_fuel_pumping.map))

for (i=1:1:length(eng.plant.init.mep_zero_fuel_total_friction.idx1_throttle))
      eng.plant.init.mep_zero_fuel_total_friction.map(:,i) = eng.plant.init.mep_zero_fuel_pumping.map(:,i)- eng.plant.init.mep_zero_fuel_non_pumping.map';
end
% end of total frictional mep calcualation
% begin conversion of mep to torque based on cylinder displacement assume 4
% stroke cumbustion cycle

eng.plant.init.trq_zero_fuel_total_friction.idx1_spd =[0:100:600];
eng.plant.init.trq_zero_fuel_total_friction.idx2_throttle = [0:5:55];
eng.plant.init.trq_zero_fuel_total_friction.map = zeros(size(eng.plant.init.mep_zero_fuel_total_friction.map));
eng.plant.init.trq_zero_fuel_total_friction.map((2:end+1),:) = eng.plant.init.mep_zero_fuel_total_friction.map.*eng.plant.init.displ_init/1000 / 4/ pi;
eng.plant.init.trq_zero_fuel_total_friction.map(1,:) =0;

% end of engine friction torque at zero fuel calculation

% Engine off torque is the engine total friction torque at WOT
eng.plant.init.trq_eng_off.idx1_spd =[0:100:600];
eng.plant.init.trq_eng_off.map      = eng.plant.init.trq_zero_fuel_total_friction.map(:,end);

% End of all fuel off trq calculations

%% Throttle position with fuel off as a fraction, i.e. 5% throttle will be 0.05
eng.plant.init.throttle_position_fuel_off = 0.05; % this can be a lookup table as a function of speed.

%%
clear F;   
