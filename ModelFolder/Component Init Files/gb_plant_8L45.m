trans_desc='GM 8-Speed Longitudinal Automatic Transmission (8L45)';
%% Transmission
gb.plant.init.inertia_in   	      = 0.005;			% kg m^2 estimated
gb.plant.init.inertia_out  	      = 0;				% kg m^2
gb.plant.init.mass.total  		  = 46.3;		        % kg - estimated
gb.plant.init.spd_thr  			  = 10;
gb.plant.init.nb_ratio            = 8;
gb.plant.init.shift_time          = 0.6;
gb.plant.init.gear.idx1_shifter   = [0 1 2 3 4 5 6 7 8 13 14 15];
gb.plant.init.gear.idx2_gear      = [0 1 2 3 4 5 6 7 8 0 -1 0];
gb.plant.init.ratio.idx1_gear     = [-1,0,1,2,3,4,5,6,7,8];
gb.plant.init.ratio.map           = [3.93 0 4.62 3.04 2.07 1.66 1.26 1.00 0.85 0.66]; 
% 8L45 Transmission Shift Lever Position
ParkGear = 1;
ReverseGear = 2;
NeutralGear = 3;
DriveGear = 4;

%% 8L45 Shift Schedules
% 6L45 Gear Shift Schedule table 
gb.ctrl.dmd.init.gear_upshift.idx1_lin_accel = [0 6.25 12.5	18.75 25 31.25 37.5	43.75 50 56.25 62.5	68.75 75 81.25 87.5	93.75 99.99847412];
gb.ctrl.dmd.init.gear_dnshift.idx1_lin_accel = [0 6.25 12.5	18.75 25 31.25 37.5	43.75 50 56.25 62.5	68.75 75 81.25 87.5	93.75 99.99847412];

gb.ctrl.dmd.init.gear_upshift.map = [...
13.703125	13.703125	13.703125	13.796875	16.703125	21.3984375	27.6015625	33.1015625	38.3984375	43.8984375	48.8984375	51	52.203125	52.8984375	53.296875	53.3984375	53.3984375;
22.1015625	22.1015625	22.1015625	24.1015625	27.796875	35.1015625	43	54.203125	64.203125	73.5	82.3984375	86.5	89	90.3984375	90.796875	90.796875	90.796875;
28.296875	28.296875	28.3984375	34.6015625	43.703125	55.5	68.296875	85	99.8984375	114	127	132.796875	136.296875	139	141	141.296875	141.296875;
38.203125	38.203125	38.203125	43.8984375	55.6015625	70.6015625	86.6015625	107.6015625	126.796875	145	161	168.296875	172.703125	176.3984375	179.203125	179.703125	179.703125;
49.296875	49.296875	49.703125	56	73.296875	93.703125	114.203125	140.796875	166.203125	193.1015625	222.796875	235	235	235	235	235	235;
64.1015625	64.1015625	64.1015625	66.3984375	85.3984375	110	135	169	216.703125	253.296875	264.5	265.8984375	266	266	266	266	266;
82.6015625	82.6015625	82.6015625	86	106	135	260.6015625	511.9921875	511.9921875	511.9921875	511.9921875	511.9921875	511.9921875	511.9921875	511.9921875	511.9921875	511.9921875];


gb.ctrl.dmd.init.gear_dnshift.map = [...
7	7	7	7	10.703125	11.703125	12.703125	14.1015625	17.1015625	21.3984375	24.703125	26.8984375	31.6015625	36.1015625	38.8984375	39.296875	39.3984375;
7	7	7	7	15	20	24.203125	27.1015625	33.6015625	39.3984375	53	65.796875	74.296875	78.5	79.703125	79.796875	79.796875;
25.203125	25.203125	25.203125	25.203125	27.6015625	32.6015625	36.296875	43.3984375	50.703125	60.703125	78	92	105	117	128	134.203125	134.296875;
35	35	35	35	36.796875	43.296875	48	58.6015625	85.703125	111.1015625	131	147.3984375	159.703125	167.703125	172.1015625	173.3984375	173.703125;
44.1015625	44.1015625	44.1015625	49.1015625	50.8984375	55.5	76.6015625	101.703125	125.8984375	151.8984375	184.796875	218.296875	221	225	225	225	225;
60.1015625	60.1015625	60.1015625	60.1015625	62.796875	80	103	128	156	202.703125	248.6015625	259.5	261.3984375	261.8984375	262	262	262;
77.6015625	77.6015625	77.6015625	77.6015625	80	103	129	160	459.3984375	505.796875	507	507	507	507	507	507	507];

gb.plant.init.eff_trq.idx1_trq =    [0:100:1000];
gb.plant.init.trq_in_max = max(gb.plant.init.eff_trq.idx1_trq);

%%losses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gb.plant.init.eff_trq.idx1_trq =    [0:100:1000];
gb.plant.init.trq_in_max = max(gb.plant.init.eff_trq.idx1_trq);

% input trq in Nm
gb.plant.init.eff_trq.idx2_spd = [0:100:1000];% input speeds in rd/s

gb.plant.init.eff_trq_ratio1.map = 0.958*ones(length(gb.plant.init.eff_trq.idx2_spd),length(gb.plant.init.eff_trq.idx1_trq));
gb.plant.init.eff_trq_ratio2.map = 0.954*ones(length(gb.plant.init.eff_trq.idx2_spd),length(gb.plant.init.eff_trq.idx1_trq));
gb.plant.init.eff_trq_ratio3.map = 0.953*ones(length(gb.plant.init.eff_trq.idx2_spd),length(gb.plant.init.eff_trq.idx1_trq));
gb.plant.init.eff_trq_ratio4.map = 0.983*ones(length(gb.plant.init.eff_trq.idx2_spd),length(gb.plant.init.eff_trq.idx1_trq));
gb.plant.init.eff_trq_ratio5.map = 0.927*ones(length(gb.plant.init.eff_trq.idx2_spd),length(gb.plant.init.eff_trq.idx1_trq));
gb.plant.init.eff_trq_ratio6.map = 0.930*ones(length(gb.plant.init.eff_trq.idx2_spd),length(gb.plant.init.eff_trq.idx1_trq));
%%%%%  7th and 8th gear efficiency should be checked with GM data %%%%%%
gb.plant.init.eff_trq_ratio7.map = 0.930*ones(length(gb.plant.init.eff_trq.idx2_spd),length(gb.plant.init.eff_trq.idx1_trq));
gb.plant.init.eff_trq_ratio8.map = 0.930*ones(length(gb.plant.init.eff_trq.idx2_spd),length(gb.plant.init.eff_trq.idx1_trq));

for cpt=1:gb.plant.init.nb_ratio,
    gb.plant.init.eff_trq.map(:,:,cpt) = eval(['gb.plant.init.eff_trq_ratio',num2str(cpt),'.map']);%create the 3 dimensions (trq, spd, ratio) map for trq loss
end

% calculate the torque losses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gb.plant.init.trq_loss.idx1_trq = gb.plant.init.eff_trq.idx1_trq;
gb.plant.init.trq_loss.idx2_spd = gb.plant.init.eff_trq.idx2_spd;
gb.plant.init.trq_loss.idx3_gear = gb.plant.init.ratio.idx1_gear(3:end);
gb.plant.init.coeff = gb.plant.init.eff_trq.idx1_trq(:)*ones(1,length(gb.plant.init.eff_trq.idx2_spd));
for cpt=1:gb.plant.init.nb_ratio,
    eval(['gb.plant.init.trq_loss_ratio',num2str(cpt),'.map = (1 - gb.plant.init.eff_trq_ratio',num2str(cpt),'.map) .* gb.plant.init.coeff;']);%calculate trq loss per ratio
    gb.plant.init.trq_loss.map(:,:,cpt) = eval(['gb.plant.init.trq_loss_ratio',num2str(cpt),'.map']);%create the 3 dimensions (trq, spd, ratio) map for trq loss
end

% calculate the maximum efficiency
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for cpt=1:gb.plant.init.nb_ratio,
   gb.plant.init.eff(cpt)=max(max(eval(['gb.plant.init.eff_trq_ratio',num2str(cpt),'.map'])));
end
gb.plant.init.eff_max=max(gb.plant.init.eff);
clear cpt tmp

% PlotGearShiftSchedule(gb.ctrl.dmd.init.gear_upshift.idx1_lin_accel,gb.ctrl.dmd.init.gear_upshift.map,gb.ctrl.dmd.init.gear_dnshift.map,'6L45');