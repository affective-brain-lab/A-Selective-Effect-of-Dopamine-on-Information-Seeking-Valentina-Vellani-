# load mixed effects package
library(lme4)
library(lmerTest)
library(car)
library(sjPlot)


setwd()

#load dataframes for mixed effects models
data <- read.csv("Exp.csv")

control_params = lmerControl(optimizer="bobyqa",optCtrl=list(maxfun=100000))

#define models 1 reuslts


W1.full <- lmer(Exp ~ MarketChange+AbsMarketChange+group_0placebo+group_0placebo*MarketChange+
                  group_0placebo*AbsMarketChange+(MarketChange+AbsMarketChange+group_0placebo+group_0placebo*MarketChange+
                                                    group_0placebo*AbsMarketChange || Subj),
                data = data, REML=FALSE, control = control_params)

summary(W1.full)
confint(W1.full, oldNames = FALSE)
tab_model(W1.full)

#define models 2 

W1.full1 <- lmer(Exp ~ MarketChange+AbsMarketChange+group_0placebo+group_0placebo*MarketChange+
                  group_0placebo*AbsMarketChange+Trial+Trial*group_0placebo+Trial*AbsMarketChange+
                   Trial*MarketChange+Trial*AbsMarketChange*MarketChange+Trial*MarketChange*group_0placebo+
                   Trial*AbsMarketChange*group_0placebo+
                   (MarketChange+AbsMarketChange+group_0placebo+group_0placebo*MarketChange+
                      group_0placebo*AbsMarketChange+Trial+Trial*group_0placebo+Trial*AbsMarketChange+
                      Trial*MarketChange+Trial*AbsMarketChange*MarketChange+Trial*MarketChange*group_0placebo+
                      Trial*AbsMarketChange*group_0placebo || Subj),
                data = data, REML=FALSE, control = control_params)

summary(W1.full1)
confint(W1.full1, oldNames = FALSE)
tab_model(W1.full1)
