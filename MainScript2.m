close all
clear all
clc

%dir = 

cd(dir)

%sub_list=
%sub_ini=
%group=


resultcorrUp = [];
resultPUp = [];

resultcorrDown = [];
resultPDown = [];
     

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


Analysis.Regression.twoChoice = {'Subject' 'market change' 'P' 'abs market change' 'P' ...
    'Intercept' 'P Int' 'SSR' 'BIC' 'Pseudo R2'};

Analysis.Expectations.Average = {'Subject' 'meanExpAll' 'RatingExpUp' 'RatingExpDown' };
Analysis.Confidence.Average = {'Subject' 'meanExpAll' 'RatingConfUp' 'RatingConfDown' };

data_allsubs = [];

for i=1:size(sub_list(:,1))
    
    result_file = sprintf('Data_Market_Task_Sub%s_%s.mat',sub_list(i,:),sub_ini(i,:)); %file to load
     %dir = 
    load([dir 'Sub' sub_list(i,:) '\' result_file]);
    
    data_exp = DATA.Trials;
    data1 = [DATA.Trials(:,[1:5 14 16 17 20:23 12])];
%     interesting columns in that big trial matrix:
%     1: block number
%     2: trial number within each block
%     3: trial number total 
%     4: reaction time to see market
%     5: market value on that trial
%     6: choice to get info (1: YES, -1: NO, 0: indifferent, NaN: missed)
%     7: Willingness to pay
%     8: reaction time to choose WTP
%     9: info delivery (1: information shown to the participant, 0: no info)
%     10: whether portfolio tracks market change on that day (1: yes, 0: no)
%     11: market value change compared to previous trial
%     12: portfolio value (in points)
%     13: cursor starting position
%     
    data1(data1(:,7)==0,6)=0; %make sure that trials where WTP is 0 are classified as Zero choice
    data1(:,14) = data1(:,6).*data1(:,7); %valenced WTP
    data1(:,15) = abs(data1(:,11)); %absolute market change
    
    % Number of trials and mean WTP and RTs - All trials
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
    
%     indices for when market change was 
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
    
%     indices for when market value is high (>0) vs low (<0) regardless of
%     going up or down
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

% % 
% %     % Effects of expectations and confidence - Second Half
    data2 = DATA.Trials;
% %     interesting columns in that big trial matrix:
% %     1: block number
% %     2: trial number within each block
% %     3: trial number total 
% %     4: reaction time to see market
% %     5: market value on that trial
% %     7: expectation rating (from -4: decreased a lot to +4: increased a lot)
% %     8: expectation RT
% %     10: confidence rating
% %     11: confidence RT
% %     12: cursor starting position
% %     14: choice to get info (1: YES, -1: NO, 0: indifferent, NaN: missed)
% %     15: number of arrow presses to choose WTP (~hesitation)
% %     16: Willingness to pay
% %     17: reaction time to choose WTP
% %     20: info delivery (1: information shown to the participant, 0: no info)
% %     21: whether portfolio tracks market change on that day (1: yes, 0: no)
% %     22: market value change compared to previous trial
% %     23: portfolio value (in points)
% % 
    data2(data2(:,16)==0,14)=0;
    data2(:,26) = data2(:,16).*data2(:,14); %valenced WTP
    data2(:,27) = abs(data2(:,22)); %absolute market change
    
    i_yes2 = data2(:,14)==1;
    i_no2 = data2(:,14)==-1;
    i_zero2 = data2(:,14)==0;
    i_missed2 = isnan(data2(:,14));
    Analysis.Expectations.NumberTrials(i+1,:) = [{sub_list(i,:)} {sum(i_yes2)} {sum(i_no2)} {sum(i_zero2)} {sum(i_missed2)}];
    Analysis.Expectations.WTP.YesNo(i+1,:) = [{sub_list(i,:)} {nanmean(data2(i_yes2,16))} {nanmean(data2(i_no2,16))}];
    Analysis.Expectations.RT.YesNo(i+1,:) = [{sub_list(i,:)} {nanmean(data2(i_yes2,17))} {nanmean(data2(i_no2,17))}];
% %     
% %     indices for trials where subject has positive vs negative
% %     expectations
    i_pos = data2(:,7)>0;
    i_neg = data2(:,7)<0;
    i_zero = data2(:,7)==0;
    n_pos = sum(i_pos);
    n_neg = sum(i_neg);
    n_zero = sum(i_zero);
    n_y_pos = sum(i_yes2 & i_pos);
    n_y_neg = sum(i_yes2 & i_neg);
    n_y_zero = sum(i_yes2 & i_zero);
    n_m_pos = sum(i_missed2 & i_pos);
    n_m_neg = sum(i_missed2 & i_neg);
    n_m_zero = sum(i_missed2 & i_zero);
    Analysis.Expectations.PropYes.PosNeg(i+1,:) = [{sub_list(i,:)} {n_pos} {n_neg} {n_zero} {n_y_pos} {n_y_neg} {n_y_zero} ...
        {n_m_pos} {n_m_neg} {n_m_zero} {n_y_pos/(n_pos-n_m_pos)} {n_y_neg/(n_neg-n_m_neg)} {n_y_zero/(n_zero-n_m_zero)}]; 
    Analysis.Expectations.WTP.PosNeg(i+1,:) = [{sub_list(i,:)} {nanmean(data2(i_pos,16))} {nanmean(data2(i_neg,16))} {nanmean(data2(i_zero,16))}];
    Analysis.Expectations.RT.PosNeg(i+1,:) = [{sub_list(i,:)} {nanmean(data2(i_pos,17))} {nanmean(data2(i_neg,17))} {nanmean(data2(i_zero,17))}];
    Analysis.Expectations.ValWTP.PosNeg(i+1,:) = [{sub_list(i,:)} {nanmean(data2(i_pos,26))} {nanmean(data2(i_neg,26))} {nanmean(data2(i_zero,26))}];
    
% %     indices for trials where subject has high vs low confidence rating
% %     med_conf = nanmedian(data2(:,10));
    med_conf = nanmedian(data2(:,10));    
    i_hic = data2(:,10)>med_conf;
    i_loc = data2(:,10)<=med_conf;
    n_hic = sum(i_hic);
    n_loc = sum(i_loc);
    n_y_hic = sum(i_yes2 & i_hic);
    n_y_loc = sum(i_yes2 & i_loc);
    n_m_hic = sum(i_missed2 & i_hic);
    n_m_loc = sum(i_missed2 & i_loc);
    Analysis.Expectations.PropYes.HiLoConf(i+1,:) = [{sub_list(i,:)} {n_hic} {n_loc} {n_y_hic} {n_y_loc} ...
        {n_m_hic} {n_m_loc} {n_y_hic/(n_hic-n_m_hic)} {n_y_loc/(n_loc-n_m_loc)}]; 
    Analysis.Expectations.WTP.HiLoConf(i+1,:) = [{sub_list(i,:)} {nanmean(data2(i_hic,16))} {nanmean(data2(i_loc,16))}];
    Analysis.Expectations.RT.HiLoConf(i+1,:) = [{sub_list(i,:)} {nanmean(data2(i_hic,17))} {nanmean(data2(i_loc,17))}];
    Analysis.Expectations.ValWTP.HiLoConf(i+1,:) = [{sub_list(i,:)} {nanmean(data2(i_hic,26))} {nanmean(data2(i_loc,26))}];
    
    Analysis.Expectations.ValWTP.PosNegConf(i+1,:) = [{sub_list(i,:)} {nanmean(data2(i_pos & i_hic,26))} ...
        {nanmean(data2(i_pos & i_loc,26))} {nanmean(data2(i_neg & i_hic,26))} {nanmean(data2(i_neg & i_loc,26))} ... 
        {sum(i_pos & i_hic)} {sum(i_pos & i_loc)} {sum(i_neg & i_hic)} {sum(i_neg & i_loc)}]; 
% %     
% %    
    data3 = [DATA.Trials(:,7)];
    
   data3(data3 == -999) = nan;
   mean={nanmean(data3(:,1))};
   data2(:,28)= data3(:,1);
   
   meanExpUp=nanmean(data2(i_up1,28));
   meanExpDown=nanmean(data2(i_down1,28));
   
   Analysis.Expectations.Average(i+1,:)=[{sub_list(i,:)} {nanmean(data2(:,28))} {meanExpUp} {meanExpDown} ];
   
   %indices for trials where subject has high vs low confidence rating
    med_conf = nanmedian(data2(:,10));
    i_hic = data2(:,10)>med_conf;
    i_loc = data2(:,10)<=med_conf;
    
    
   data4 = [data2(:,10)];
    
   data4(data4 == -999) = nan;
   
   data2(:,29)= data4(:,1);
    
   meanConfUp=nanmean(data2(i_up1,29));
   meanConfDown=nanmean(data2(i_down1,29));
   Analysis.Confidence.Average(i+1,:)=[{sub_list(i,:)} {nanmean(data2(:,29))} {meanConfUp} {meanConfDown} ];
    
% %    
% %     correlate expecation and market change
    exp=data2(:,28);
    change=data2(:,22);
       expUp=data2(i_up1,28)
       expDown=data2(i_down1,28)
       marketUp=data2(i_up1,22);
       marketDown=data2(i_down1,22);
    
[corrUp, pvalueUp] = corrcoef(expUp,marketUp,'rows','complete');
    corrUp=corrUp(1,2)
    pvalueUp=pvalueUp(1,2)
    
         resultcorrUp = [resultcorrUp; corrUp];
         resultPUp = [resultPUp; pvalueUp];
         
         
         [corrDown, pvalueDown] = corrcoef(expDown,marketDown,'rows','complete');
    corrDown=corrDown(1,2)
    pvalueDown=pvalueDown(1,2)
    
         resultcorrDown = [resultcorrDown; corrDown];
         resultPDown = [resultPDown; pvalueDown];
%      
% %     
% %     % prepare matrix for regressions
data_reg = data1(:,[6 14 11 5 9 10 12 3 13]);
% %     keep only useful information for regression: 
% %     1.choice
% %     2.val WTP
% %     3.market change
% %     4.market value
% %     5.info delivered or not
% %     6.whether info tracks market or not, 
% %     7.portfolio value
% %     8.trial number
% %     9.cursor starting position
% %     10.market change since last info
    
   
     
data_reg(data_reg(:,1)==-1,1)=0; %recode avoid info trials as 0 for choice regression
   
    data_reg(:,17) = abs(data_reg(:,3)); %absolute market change
    data_reg(:,18) = data2(:,22) %value compared to value in previous trials
    
   
    data_reg(isnan(data_reg(:,1)),:)=[];  

% % 
% %     prepare final matrix before regression, with zscored regressors
% %     col 1: choice
% %     col 2: val WTP
% %     col 3: signed market change
% %     col 4: absolute market change
% %     col 5: market value
% %     col 6: known portfolio value
% %     col 7: number of trials since last info
% %     col 8: time (trial number)
% %     col 9: cursor starting position
% % %     data_reg_f = [data_reg(:,[1 2]) zscore(data_reg(:,3)) zscore(data_reg(:,17)) zscore(data_reg(:,4)) zscore(data_reg(:,12)) ...
% % %         zscore(data_reg(:,11)) zscore(data_reg(:,8)) zscore(data_reg(:,9))];
% % 
data_reg_f = [data_reg(:,[1 2]) zscore(data_reg(:,3)) zscore(data_reg(:,17))];

%choice
%wtp
%signed market change
%absolute market change
% % %     
ntrials = length(data_reg_f(:,1));




%%model WTP market change and abs market change
      npar = 2;
    [b_wtp,d_wtp,st_wtp] = glmfit(data_reg_f(:,3:4),data_reg_f(:,2));
    SSRall = sum(st_wtp.resid.^2);
    BIC_all = ntrials*log(SSRall/ntrials) + npar*log(ntrials);
    pseudoR2_all = 1 - SSRall/((ntrials-1)*var(data_reg_f(:,2)));    
    Analysis.Regression.twoWTP(i+1,:) = [{sub_list(i,:)} {b_wtp(2)} {st_wtp.p(2)} {b_wtp(3)} {st_wtp.p(3)} ...
         {b_wtp(1)} {st_wtp.p(1)} {SSRall} {BIC_all} {pseudoR2_all}];





% % model con choice with market change and abs market change
     npar=2;
    [b_ch,d_ch,st_ch] = glmfit(data_reg_f(:,3:4),data_reg_f(:,1),'binomial','link','logit');
    pFitted = glmval(b_ch,data_reg_f(:,3:4),'logit');
    log_all = log(binopdf(data_reg_f(:,1),1,pFitted));
    LL_all = nansum(log_all);    
    BIC_all = -2*LL_all + npar.*log(ntrials);
    pseudoR2_all = 1 - LL_all/(log(0.5)*ntrials);
    Analysis.Regression.twoChoice(i+1,:) = [{sub_list(i,:)} {b_ch(2)} {st_ch.p(2)} {b_ch(3)} {st_ch.p(3)} ...
        {b_ch(1)} {st_ch.p(1)} {LL_all} {BIC_all} {pseudoR2_all}];
    
    
    
  
end 
save([dir 'Beta_lesspara.mat'],'Analysis')
