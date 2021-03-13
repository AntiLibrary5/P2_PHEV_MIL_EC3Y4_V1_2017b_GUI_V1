clear
DriveCycle=get_param('Run_Simulator/Inputs','DriveCyc');
ess.plant.initial_soc=str2num(get_param('Run_Simulator/Inputs','init_soc'));
ess.plant.cd_soc_min=str2num(get_param('Run_Simulator/Inputs','cd_soc_min'));
ess.plant.cs_soc_max=str2num(get_param('Run_Simulator/Inputs','cs_soc_max'));
ess.plant.cs_soc_min=str2num(get_param('Run_Simulator/Inputs','cs_soc_min'));
veh.init.mass=str2num(get_param('Run_Simulator/Inputs','veh_mass'));
Tamb=str2num(get_param('Run_Simulator/Inputs','Tamb'));
ResFileName=get_param('Run_Simulator/Inputs','ResFileName');
run  Main_Init.m
run  HCU_Calibration.m
run Run_Cycle.m
a=[0.1 0.2 0.3 0.4 0.6 0.8];
CD1=zeros(1,6);
CS1=zeros(1,6);
EC1=zeros(1,6);
CD_r=zeros(1,6);
for i=1:6
    factor=a(i);
sim  P2_Parallel_MIL_withTrailer.slx
k_CD=find(SOC<ess.plant.cs_soc_min,1);

CD_EC = WhPkm_batt(k_CD)+WhPkm_Fuel(k_CD); % Wh/km
Fuel_CS=Fuel_mass(end)-Fuel_mass(k_CD)/1000;  % kg
CS_Ele = (ess_wh(end)-ess_wh(k_CD))/1000/0.25/(Engine.Fuel.Lower_Heating_Value*2.7778e-7);
FC_correct=(CS_Ele+Fuel_CS)/(veh_dist_meter_hist(end)/1000-veh_dist_meter_hist(k_CD)/1000);
CS_EC=FC_correct*(Engine.Fuel.Lower_Heating_Value*2.7778e-7);

CD_range=veh_dist_meter_hist(k_CD)*0.000621371; %mi
UF = 1-exp(-(10.52*(CD_range/399.9)-7.282*(CD_range/399.9)^2-26.37*(CD_range/399.9)^3+79.08*(CD_range/399.9)^4-77.36*(CD_range/399.9)^5+26.07*(CD_range/399.9)^6));

EC_UF = CD_EC*UF+CS_EC*(1-UF);

CD1(i)=CD_EC;
CS1(i)=CS_EC;
EC1(i)=EC_UF;
CD_r(i)=CD_range;
ResFileName='Results_EnEC%i';
 ResFileName=['Results/',ResFileName,'.mat'];
 save(ResFileName);
  VTSFile=['Results/EnEC.mat'];
save(VTSFile,'EC_UF');

end