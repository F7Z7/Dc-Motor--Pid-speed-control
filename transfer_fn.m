%% Motor Transfer Function
% Transfer function of the motor: 
% G(s) = Kt / ( (Js + B)(Ls + R) + Kt*Kb )


% Electrical parameters
L = 0.5;     % Inductance (Henrys)
R = 1.0;     % Resistance (Ohms)

% Mechanical parameters
J = 0.01;    % Moment of inertia of the rotor (kg*m^2)
B = 0.1;     % Damping coefficient / Viscous friction (N*m*s)

% Electromechanical constants
Kt = 0.01;   % Motor Torque constant (N*m/A)
Kb = 0.01;   % Back EMF constant (V*s/rad)


% Denominator: (Js + B)(Ls + R) + Kt*Kb
% We use conv() for polynomial multiplication
mech=[J, B];
elec=[L R];

denom_tf=(conv(mech,elec)+Kt*Kb);
num_tf=Kt;

%tf of motor
motor_tf=tf(num_tf,denom_tf);


%the constants->kp,ki,kd
kp=393.138;
kd=49.1423;
ki=786.277;
cl_tf = feedback(kp * motor_tf, 1);

%plots section
figure('Position', [100, 100, 1200, 400]);

subplot(1,2,1);
step(cl_tf)
title('Step Response')

subplot(1,2,2);
margin(cl_tf)
title('Bode Plot')