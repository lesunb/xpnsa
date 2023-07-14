function calc_risk_pct
  "Function that evaluates a sensor measurement to provide a risk percentage of the patient"

  input Real measurement "Sensor's measurement";
  input Real LowRisk_lb "Lower bound for a low risk measurement";
  input Real LowRisk_ub "Upper bound for a low risk measurement";
  input Real MidRisk0_lb "Lower bound for a medium risk measurement"; 
  input Real MidRisk0_ub "Upper bound for a medium risk measurement";
  input Real HighRisk0_lb "Lower bound for a high risk measurement"; 
  input Real HighRisk0_ub "Upper bound for a high risk measurement";
  input Real MidRisk1_lb "Lower bound for a second medium risk measurement"; 
  input Real MidRisk1_ub "Upper bound for a second medium risk measurement";
  input Real HighRisk1_lb "Lower bound for a second high risk measurement"; 
  input Real HighRisk1_ub "Upper bound for a second high risk measurement";
  
  input Real LowRisk_lb_pct "Lower bound for the low risk percentage"; 
  input Real LowRisk_ub_pct "Upper bound for the low risk percentage";
  input Real MidRisk0_lb_pct "Lower bound for the medium risk percentage"; 
  input Real MidRisk0_ub_pct "Upper bound for the medium risk percentage";
  input Real HighRisk0_lb_pct "Lower bound for the high risk percentage"; 
  input Real HighRisk0_ub_pct "Upper bound for the high risk percentage";
  
  output Real risk_pct;
 
protected
  Real mediumValue;
  Real displacement; 

algorithm
  //risk_pct := measurement - 50;
  
  if measurement >= LowRisk_lb and measurement <= LowRisk_ub then
    mediumValue := (LowRisk_ub + LowRisk_lb)/2.0;
    displacement := abs(measurement - mediumValue) / (LowRisk_ub - mediumValue);
    risk_pct := ((displacement - 0.0) / (1.0 - 0.0)) * (LowRisk_ub_pct - LowRisk_lb_pct) + LowRisk_lb_pct;
  elseif measurement >= MidRisk0_lb and measurement <= MidRisk0_ub then
    displacement := abs(measurement - MidRisk0_ub) / (MidRisk0_ub - MidRisk0_lb);
    risk_pct := ((displacement - 0.0) / (1.0 - 0.0)) * (MidRisk0_ub_pct - MidRisk0_lb_pct) + MidRisk0_lb_pct;
  elseif measurement >= MidRisk1_lb and measurement <= MidRisk1_ub then
    displacement := abs(measurement - MidRisk1_lb) / (MidRisk1_ub - MidRisk1_lb);
    risk_pct := ((displacement - 0.0) / (1.0 - 0.0)) * (MidRisk0_ub_pct - MidRisk0_lb_pct) + MidRisk0_lb_pct;
  elseif measurement >= HighRisk0_lb and measurement <= HighRisk0_ub then
    displacement := abs(measurement - HighRisk0_ub) / (HighRisk0_ub - HighRisk0_lb);
    risk_pct := ((displacement - 0.0) / (1.0 - 0.0)) * (HighRisk0_ub_pct - HighRisk0_lb_pct) + HighRisk0_lb_pct;
  elseif measurement >= HighRisk1_lb and measurement <= HighRisk1_ub then
    displacement := abs(measurement - HighRisk1_lb) / (HighRisk1_ub - HighRisk1_lb);
    risk_pct := ((displacement - 0.0) / (1.0 - 0.0)) * (HighRisk0_ub_pct - HighRisk0_lb_pct) + HighRisk0_lb_pct;
  else
    risk_pct := -1;
  end if;

end calc_risk_pct;
