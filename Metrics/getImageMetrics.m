function metrics = getImageMetrics(M,P,F)
%GETIMAGEMETRICS Summary of this function goes here
%   Detailed explanation goes here
%find Spacial coefficient
metrics(1)=spatial(F,P);
%find Root Mean Square Error
metrics(2)=RMSE(M,F);
end

