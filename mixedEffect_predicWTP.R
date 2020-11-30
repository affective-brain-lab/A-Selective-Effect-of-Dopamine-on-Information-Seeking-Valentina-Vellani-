# load mixed effects package
library(lme4)
library(lmerTest)
library(car)
library(sjPlot)


setwd()

#load dataframes for mixed effects models
data <- read.csv("All_WTP_choice.csv")
data1 <- read.csv("dopa.csv")
data2 <- read.csv("placebo.csv")
data3 <- read.csv("gain.csv")
data4 <- read.csv("loss.csv")
data5 <- read.csv("gain_dopa.csv")
data6 <- read.csv("gain_placebo.csv")
data7 <- read.csv("loss_dopa.csv")
data8 <- read.csv("loss_placebo.csv")



#control parameters to use in all models
control_params = lmerControl(optimizer="bobyqa",optCtrl=list(maxfun=100000))


#define models 1 reuslts


W1.full <- lmer(vWTP ~ MarketChange+AbsMarketChange+group_0placebo+group_0placebo*MarketChange+
                  group_0placebo*AbsMarketChange+(MarketChange+AbsMarketChange+group_0placebo+group_0placebo*MarketChange+
                                                    group_0placebo*AbsMarketChange || Subj),
                data = data, REML=FALSE, control = control_params)



summary(W1.full)
anova(W1.full)
confint(W1.full1, oldNames = FALSE)
tab_model(W1.full)


#define models 2 results DOPA
W1.full2 <- lmer(vWTP ~ MarketChange+AbsMarketChange+(MarketChange+AbsMarketChange || Subj),
                data = data1, REML=FALSE, control = control_params)

summary(W1.full2)
anova(W1.full2)
confint(W1.full2, oldNames = FALSE)
tab_model(W1.full2)


#define models 2 results PLACEBO
W1.full2 <- lmer(vWTP ~ MarketChange+AbsMarketChange+(MarketChange+AbsMarketChange || Subj),
                 data = data2, REML=FALSE, control = control_params)

summary(W1.full2)
anova(W1.full2)
confint(W1.full2, oldNames = FALSE)
tab_model(W1.full2)


#define models 3 results DOPA
W1.full2 <- lmer(vWTP ~ Val_1up+(Val_1up || Subj),
                 data = data1, REML=FALSE, control = control_params)

summary(W1.full2)
anova(W1.full2)
confint(W1.full2, oldNames = FALSE)
tab_model(W1.full2)



#define models 2 results PLACEBO
W1.full2 <- lmer(vWTP ~ Val_1up+(Val_1up || Subj),
                 data = data2, REML=FALSE, control = control_params)

summary(W1.full2)
anova(W1.full2)
confint(W1.full2, oldNames = FALSE)
tab_model(W1.full2)



#define models 4 results GAIN


W1.full3 <- lmer(vWTP ~ Trial+AbsMarketChange+group_0placebo+
                   group_0placebo*AbsMarketChange+group_0placebo*Trial+
                   AbsMarketChange*Trial+group_0placebo*AbsMarketChange*Trial+
                   (Trial+AbsMarketChange+group_0placebo+
                      group_0placebo*AbsMarketChange+group_0placebo*Trial+
                      AbsMarketChange*Trial+group_0placebo*AbsMarketChange*Trial || Subj),
                 data = data3, REML=FALSE, control = control_params)

summary(W1.full3)
confint(W1.full3, oldNames = FALSE)
tab_model(W1.full3)

#define models 4 results LOSS

W1.full4 <- lmer(vWTP ~ Trial+AbsMarketChange+group_0placebo+
                   group_0placebo*AbsMarketChange+group_0placebo*Trial+
                   AbsMarketChange*Trial+group_0placebo*AbsMarketChange*Trial+
                   (Trial+AbsMarketChange+group_0placebo+
                      group_0placebo*AbsMarketChange+group_0placebo*Trial+
                      AbsMarketChange*Trial+group_0placebo*AbsMarketChange*Trial || Subj),
                 data = data4, REML=FALSE, control = control_params)



summary(W1.full4)
confint(W1.full4, oldNames = FALSE)
tab_model(W1.full4)

#define models 5 results GAIN_DOPA


W1.full5 <- lmer(vWTP ~ Trial+AbsMarketChange+AbsMarketChange*Trial+
                   (Trial+AbsMarketChange+AbsMarketChange*Trial || Subj),
                 data = data5, REML=FALSE, control = control_params)

summary(W1.full5)
confint(W1.full5, oldNames = FALSE)
tab_model(W1.full5)

#define models 5 results GAIN_PLACEBO


W1.full6 <- lmer(vWTP ~ Trial+AbsMarketChange+AbsMarketChange*Trial+
                   (Trial+AbsMarketChange+AbsMarketChange*Trial || Subj),
                 data = data6, REML=FALSE, control = control_params)

summary(W1.full6)
confint(W1.full6, oldNames = FALSE)
tab_model(W1.full6)

#define models 5 results LOSS_DOPA


W1.full7 <- lmer(vWTP ~ Trial+AbsMarketChange+AbsMarketChange*Trial+
                   (Trial+AbsMarketChange+AbsMarketChange*Trial || Subj),
                 data = data7, REML=FALSE, control = control_params)
summary(W1.full7)
confint(W1.full7, oldNames = FALSE)
tab_model(W1.full7)

#define models 5 results LOSS_PLACEBO

W1.full8 <- lmer(vWTP ~ Trial+AbsMarketChange+AbsMarketChange*Trial+
                   (Trial+AbsMarketChange+AbsMarketChange*Trial || Subj),
                 data = data8, REML=FALSE, control = control_params)

summary(W1.full8)
confint(W1.full8, oldNames = FALSE)
tab_model(W1.full8)