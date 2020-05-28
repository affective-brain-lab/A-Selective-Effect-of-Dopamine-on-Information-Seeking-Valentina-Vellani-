close all
clear all
clc


 
%dir = 
 

cd(dir)


%study1 dopa
 %sub_list = 
 %su_ini = 
 %group = 

Analysis.Group = group;

Analysis.All.NumberTrials = {'Subject' 'Number of YES trials' 'Number of NO trials' 'Number of zero trials' 'Number of missed trials'};
Analysis.All.WTP.YesNo = {'Subject' 'Mean WTP YES' 'Mean WTP NO'};
Analysis.All.RT.YesNo = {'Subject' 'Mean RT YES' 'Mean RT NO'};
Analysis.All.PropYesNo.UpDown = {'Subject' 'Number of UP trials' 'Number of DOWN trials' 'YES - UP' 'YES - DOWN' 'NO - UP' 'NO - DOWN' ...
    'missed - UP' 'missed - DOWN' 'Proportion YES - UP' 'Proportion YES - DOWN' 'Proportion NO - UP' 'Proportion NO - DOWN'};
Analysis.All.WTP.UpDown = {'Subject' 'Mean WTP market up' 'Mean WTP market down' 'Mean WTP YES UP' 'Mean WTP YES DOWN' 'Mean WTP NO UP' 'Mean WTP NO DOWN'};
Analysis.All.RT.UpDown = {'Subject' 'Mean RT choice market up' 'Mean RT choice market down'};
Analysis.All.ValWTP.AllUpDown = {'Subject' 'Mean Valenced WTP All' 'Mean Valenced WTP UP' 'Mean Valenced WTP DOWN'};

Analysis.All.PropYes.BigSmall = {'Subject' 'Number of BIG trials' 'Number of SMALL trials' 'YES - BIG' 'YES - SMALL' 'missed - BIG' 'missed - SMALL' ...
    'Proportion YES - BIG' 'Proportion YES - SMALL'};
Analysis.All.WTP.BigSmall = {'Subject' 'Mean WTP big change' 'Mean WTP small change'};
Analysis.All.RT.BigSmall = {'Subject' 'Mean RT choice big change' 'Mean RT choice small change'};
Analysis.All.ValWTP.BigSmall = {'Subject' 'Mean Valenced WTP big change' 'Mean Valenced WTP small change'};

Analysis.All.PropYes.HiLoVal = {'Subject' 'Number of HIGH trials' 'Number of LOW trials' 'YES - HIGH' 'YES - LOW' 'missed - HIGH' 'missed - LOW' ...
    'Proportion YES - HIGH' 'Proportion YES - LOW'};
Analysis.All.WTP.HiLoVal = {'Subject' 'Mean WTP high val' 'Mean WTP low val'};
Analysis.All.RT.HiLoVal = {'Subject' 'Mean RT choice high val' 'Mean RT choice low val'};
Analysis.All.ValWTP.HiLoVal = {'Subject' 'Mean Valenced WTP high val' 'Mean Valenced WTP low val'};

Analysis.Expectations.NumberTrials = {'Subject' 'Number of YES trials' 'Number of NO trials' 'Number of zero trials' 'Number of missed trials'};
Analysis.Expectations.WTP.YesNo = {'Subject' 'Mean WTP YES' 'Mean WTP NO'};
Analysis.Expectations.RT.YesNo = {'Subject' 'Mean RT YES' 'Mean RT NO'};

Analysis.Expectations.PropYes.PosNeg = {'Subject' 'Number of POS trials' 'Number of NEG trials' 'Number of ZERO EXP trials' ...
    'YES - POS' 'YES - NEG' 'YES - ZERO EXP' 'missed - POS' 'missed - NEG' 'missed - ZERO EXP' ...
    'Proportion YES - POS' 'Proportion YES - NEG' 'Proportion YES - ZERO EXP'};
Analysis.Expectations.WTP.PosNeg = {'Subject' 'Mean WTP pos exp' 'Mean WTP neg exp' 'Mean WTP zero exp'};
Analysis.Expectations.RT.PosNeg = {'Subject' 'Mean RT choice pos exp' 'Mean RT choice neg exp' 'Mean RT choice zero exp'};
Analysis.Expectations.ValWTP.PosNeg = {'Subject' 'Mean Valenced WTP POS' 'Mean Valenced WTP NEG' 'Mean Valenced WTP ZERO EXP'};

Analysis.Expectations.PropYes.HiLoConf= {'Subject' 'Number of HIGH CONF trials' 'Number of LOW CONF trials' 'YES - HIGH CONF' 'YES - LOW CONF' 'missed - HIGH CONF' 'missed - LOW CONF' ...
    'Proportion YES - HIGH CONF' 'Proportion YES - LOW CONF'};
Analysis.Expectations.WTP.HiLoConf = {'Subject' 'Mean WTP high conf' 'Mean WTP low conf'};
Analysis.Expectations.RT.HiLoConf = {'Subject' 'Mean RT choice high conf' 'Mean RT choice low conf'};
Analysis.Expectations.ValWTP.HiLoConf = {'Subject' 'Mean Valenced high conf' 'Mean Valenced low conf'};

Analysis.Expectations.ValWTP.PosNegConf = {'Subject' 'Mean WTP Pos High conf' 'Mean WTP Pos Low conf' ...
    'Mean WTP Neg High conf' 'Mean WTP Neg Low conf' 'Ntrials Pos High conf' 'Ntrials WTP Pos Low conf' ...
    'Ntrials Neg High conf' 'Ntrials WTP Neg Low conf'};

Analysis.Regression.Choice = {'Subject' 'Beta Market Change' 'P' 'Beta Absolute Market Change' 'P' ...
    'Beta Market Value' 'P'  'Intercept' 'P Int' 'SSR' 'BIC' 'Pseudo R2'};
Analysis.Regression.ValWTP = Analysis.Regression.Choice;





Analysis.Expectations.Average = {'Subject' 'meanExpAll' 'RatingExpUp' 'RatingExpDown' };
Analysis.Confidence.Average = {'Subject' 'meanExpAll' 'RatingConfUp' 'RatingConfDown' };
result=[];
binsMatrix=zeros(200,3); 


for i=1:size(sub_list(:,1))
    
    result_file = sprintf('Data_Market_Task_Sub%s_%s.mat',sub_list(i,:),sub_ini(i,:)); %file to load
   %dir =

    load([dir 'Sub' sub_list(i,:) '\' result_file]);
    
    data_exp = DATA.TrialsExpectations;
    data_exp(:,1) = data_exp(:,1)+2; %recode to block number 3 and 4
    data_exp(:,3) = data_exp(:,3)+100; %recode to trials 101 to 200
    data1 = [DATA.Trials(:,[1:5 8 10 11 14:17 6]); ...
        data_exp(:,[1:5 14 16 17 20:23 12])];
    %interesting columns in that big trial matrix:
    %1: block number
    %2: trial number within each block
    %3: trial number total 
    %4: reaction time to see market
    %5: market value on that trial
    %6: choice to get info (1: YES, -1: NO, 0: indifferent, NaN: missed)
    %7: Willingness to pay
    %8: reaction time to choose WTP
    %9: info delivery (1: information shown to the participant, 0: no info)
    %10: whether portfolio tracks market change on that day (1: yes, 0: no)
    %11: market value change compared to previous trial
    %12: portfolio value (in points)
    %13: cursor starting position
    
    data1(data1(:,7)==0,6)=0; %make sure that trials where WTP is 0 are classified as Zero choice
    data1(:,14) = data1(:,6).*data1(:,7); %valenced WTP
    data1(:,15) = abs(data1(:,11)); %absolute market change
    
    %% Number of trials and mean WTP and RTs - All trials
    i_yes1 = data1(:,6)==1;
    i_no1 = data1(:,6)==-1;
    i_zero1 = data1(:,6)==0;
    i_missed1 = isnan(data1(:,6));
    Analysis.All.NumberTrials(i+1,:) = [{sub_list(i,:)} {sum(i_yes1)} {sum(i_no1)} {sum(i_zero1)} {sum(i_missed1)}];
    Analysis.All.RT.YesNo(i+1,:) = [{sub_list(i,:)} {nanmean(data1(i_yes1,8))} {nanmean(data1(i_no1,8))}];
    Analysis.All.WTP.YesNo(i+1,:) = [{sub_list(i,:)} {nanmean(data1(i_yes1,7))} {nanmean(data1(i_no1,7))}];
    
    %indices for trials where market went up vs trials where market went down
    i_up1 = data1(:,11)>0;
    i_down1 = data1(:,11)<0;
    n_up = sum(i_up1);
    n_down = sum(i_down1);
    n_n_u = sum(i_no1 & i_up1);
    n_n_d = sum(i_no1 & i_down1);
    n_y_u = sum(i_yes1 & i_up1);
    n_y_d = sum(i_yes1 & i_down1);
    n_m_u = sum(i_missed1 & i_up1);
    n_m_d = sum(i_missed1 & i_down1);
    Analysis.All.PropYesNo.UpDown(i+1,:) = [{sub_list(i,:)} {n_up} {n_down} {n_y_u} {n_y_d} {n_n_u} {n_n_d} {n_m_u} {n_m_d} ...
        {n_y_u/(n_up-n_m_u)} {n_y_d/(n_down-n_m_d)} {n_n_u/(n_up-n_m_u)} {n_n_d/(n_down-n_m_d)}];
    Analysis.All.WTP.UpDown(i+1,:) = [{sub_list(i,:)} {nanmean(data1(i_up1,7))} {nanmean(data1(i_down1,7))} {nanmean(data1(i_yes1 & i_up1,7))} ...
        {nanmean(data1(i_yes1 & i_down1,7))} {nanmean(data1(i_no1 & i_up1,7))} {nanmean(data1(i_no1 & i_down1,7))}];
    Analysis.All.RT.UpDown(i+1,:) = [{sub_list(i,:)} {nanmean(data1(i_up1,8))} {nanmean(data1(i_down1,8))}];
    Analysis.All.ValWTP.AllUpDown(i+1,:) = [{sub_list(i,:)} {nanmean(data1(:,14))} {nanmean(data1(i_up1,14))} {nanmean(data1(i_down1,14))}];
    
    %indices for when market change was 
%    vs small (regardless of direction)
    med_ch = median(data1(:,15));
    i_sm = data1(:,15)<=med_ch;
    i_big = data1(:,15)>med_ch;
    n_sm = sum(i_sm);
    n_big = sum(i_big);
    n_y_s = sum(i_yes1 & i_sm);
    n_y_b = sum(i_yes1 & i_big);
    n_m_s = sum(i_missed1 & i_sm);
    n_m_b = sum(i_missed1 & i_big);
    Analysis.All.PropYes.BigSmall(i+1,:) = [{sub_list(i,:)} {n_big} {n_sm} {n_y_b} {n_y_s} {n_m_b} {n_m_s} ...
        {n_y_b/(n_big-n_m_b)} {n_y_s/(n_sm-n_m_s)}];
    Analysis.All.WTP.BigSmall(i+1,:) = [{sub_list(i,:)} {nanmean(data1(i_big,7))} {nanmean(data1(i_sm,7))}];
    Analysis.All.RT.BigSmall(i+1,:) = [{sub_list(i,:)} {nanmean(data1(i_big,8))} {nanmean(data1(i_sm,8))}];
    Analysis.All.ValWTP.BigSmall(i+1,:) = [{sub_list(i,:)} {nanmean(data1(i_big,14))} {nanmean(data1(i_sm,14))}];
    
    %indices for when market value is high (>0) vs low (<0) regardless of
    %going up or down
    i_hi = data1(:,5)>0;
    i_lo = data1(:,5)<0;
    n_hi = sum(i_hi);
    n_lo = sum(i_lo);
    n_y_h = sum(i_yes1 & i_hi);
    n_y_l = sum(i_yes1 & i_lo);
    n_m_h = sum(i_missed1 & i_hi);
    n_m_l = sum(i_missed1 & i_lo);
    Analysis.All.PropYes.HiLoVal(i+1,:) = [{sub_list(i,:)} {n_hi} {n_lo} {n_y_h} {n_y_l} {n_m_h} {n_m_l} ...
        {n_y_h/(n_hi-n_m_h)} {n_y_l/(n_lo-n_m_l)}];
    Analysis.All.WTP.HiLoVal(i+1,:) = [{sub_list(i,:)} {nanmean(data1(i_hi,7))} {nanmean(data1(i_lo,7))}];
    Analysis.All.RT.HiLoVal(i+1,:) = [{sub_list(i,:)} {nanmean(data1(i_hi,8))} {nanmean(data1(i_lo,8))}];
    Analysis.All.ValWTP.HiLoVal(i+1,:) = [{sub_list(i,:)} {nanmean(data1(i_hi,14))} {nanmean(data1(i_lo,14))}];
    

   
   
   

 
   %create a new matrix
     
     datanew=[data1(:,[1 2 3 6 11 ])]
      result = [result; datanew];
    
%      block number
%      trial number within each block
%      trial number total 
%      choice to get info (1: YES, -1: NO, 0: indifferent, NaN: missed)
%      market value change compared to previous trial   
    
%select the first 5 rows for each subject

for k=1:200
       
    up=0;
    upYes=0;
    upNo=0;
       if datanew(k,5)>0
            up=up+1;
            if datanew(k,4)==1
                upYes=upYes+1;
            elseif datanew(k,4)==-1
                upNo=upNo+1;
                end
       end   
   
     binsMatrix(k,1)= binsMatrix(k,1) + up;
     binsMatrix(k,2)= binsMatrix(k,2) + upYes;
     binsMatrix(k,3)= binsMatrix(k,3) + upNo;
end     
    
end 
   



 

save([dir 'mixed.mat'],'Analysis')



    