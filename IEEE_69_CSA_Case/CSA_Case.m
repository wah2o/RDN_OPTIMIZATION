function CSA_Case
clear all
clc
[g_best,ConvergenceCurves]=CrowSearchAlgorithm;
[Fit,PL,QL,VD,V,VSI,Pl,Ql]=Load_Flow(g_best); % Load Flow 
V_base=load('VOLT_BASE.m');
P_base=load('VOLT_BASE.m');

%% Results
disp('                            ')
disp('%%%%%%%%%%%%%%%%%%% CSA Results %%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('------------------------------------------------------')
disp(['Capacitor Size (Mvar):                 ' num2str(round(g_best(1)/1000,4))]);
disp(['Capacitor Location (Bus):              ' num2str(round(g_best(2),0))]);
disp(['Fitness Value (PU):                    ' num2str(round(Fit,4))]);
disp('------------------------------------------------------')
disp('                            ')
disp('%%%%%%%%%%%%%%%%%%% System Results %%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('------------------------------------------------------')
disp(['Power-Loss (KW):                       ' num2str(round(PL,2))]);
disp(['Reactive Power-Loss (KW):              ' num2str(round(QL,2))]);
disp(['Voltage Deviation:                     ' num2str(round(VD,2))]);
disp(['Voltage Stabiliy Index:                ' num2str(round(VSI,2))]);
disp('------------------------------------------------------')
figure (1);
plot(V,LineWidth=1.5)
hold on
plot(V_base,LineWidth=1.5)
title('Voltage Profile')
xlabel('Bus');
ylabel('Voltage');
legend('CSA Case','Base Case')
grid on;
hold off
figure (2);
plot(ConvergenceCurves,LineWidth=1.5)
title('Convergence curves')
xlabel('Iteration');
ylabel('Best Value');
grid on;
figure (3);
bar(Pl*100000,LineWidth=1.5)
% hold on
% bar(P_base,LineWidth=1.5)
title('ACTIVE Power Loss')
xlabel('Bus');
ylabel('Active Power (Kw)');
grid on;
figure (4);
bar(Ql*100000,LineWidth=1.5)
%hold on
%bar(Q_base,LineWidth=1.5)
title('REACTIVE Power Loss')
xlabel('Bus');
ylabel('Reactive Power (Kvar)');
grid on;
end