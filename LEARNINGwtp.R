# load mixed effects package
library(lme4)
library(lmerTest)
library(car)
library(sjPlot)


setwd("")

#load dataframes for mixed effects models
data <- read.csv("Learning_wtp_p.csv")
data1 <- read.csv("Learning_wtp_d.csv")
control_params = lmerControl(optimizer="bobyqa",optCtrl=list(maxfun=100000))

#define models 1 reuslts
W1.full <- lmer(vWTP ~ portvalue_tM1_subj+(portvalue_tM1_subj|| Subj_new),
                data = data1, REML=FALSE, control = control_params)

summary(W1.full)
confint(W1.full, oldNames = FALSE)
tab_model(W1.full)

#define models 2 reuslts
W1.full <- lmer(vWTP ~ Known_change_exp+(Known_change_exp|| Subj_new),
                data = data1, REML=FALSE, control = control_params)

summary(W1.full)
confint(W1.full, oldNames = FALSE)
tab_model(W1.full)

#define models 3 reuslts
W1.full <- lmer(vWTP ~ change_exp+(change_exp|| Subj_new),
                data = data1, REML=FALSE, control = control_params)

summary(W1.full)
confint(W1.full, oldNames = FALSE)
tab_model(W1.full)

#define models 1 reuslts PLACEBO
W1.full <- lmer(vWTP ~ portvalue_tM1_subj+(portvalue_tM1_subj|| Subj_new),
                data = data, REML=FALSE, control = control_params)

summary(W1.full)
confint(W1.full, oldNames = FALSE)
tab_model(W1.full)

#define models 2 reuslts
W1.full <- lmer(vWTP ~ Known_change_exp+(Known_change_exp|| Subj_new),
                data = data, REML=FALSE, control = control_params)

summary(W1.full)
confint(W1.full, oldNames = FALSE)
tab_model(W1.full)

#define models 3 reuslts
W1.full <- lmer(vWTP ~ change_exp+(change_exp|| Subj_new),
                data = data, REML=FALSE, control = control_params)

summary(W1.full)
confint(W1.full, oldNames = FALSE)
tab_model(W1.full)
