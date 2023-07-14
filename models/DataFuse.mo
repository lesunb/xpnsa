function DataFuse
  input Real oximeter;
  input Real temperature;
  input Real heartRate;
  input Real abpd;
  input Real abps;
  
  output Real overall_risk;
  
protected
  Real min_val = -1 "Minimum possible value";
  Real max_val = 1000 "Maximum possible value";
  Real number_sensors = 5;
  Real average;
  Real dev_ox, dev_temp, dev_hr, dev_abpd, dev_abps;
  Real weighted_average = 0.0;
  Real weight_sum = 0.0;
  
  
algorithm
    average := (oximeter + temperature + heartRate + abpd + abps) / number_sensors;
    
    dev_ox := oximeter - average;
    dev_temp := temperature - average;
    dev_hr := heartRate - average;
    dev_abpd := abpd - average;
    dev_abps := abps - average;
    
    max_val := max(i for i in {dev_ox, dev_temp, dev_hr, dev_abpd, dev_abps});
    min_val := min(i for i in {dev_ox, dev_temp, dev_hr, dev_abpd, dev_abps});
    
    overall_risk := average;
    
    if(max_val - min_val > 0.0) then
      dev_ox := (dev_ox - min_val) / (max_val - min_val);
      dev_temp := (dev_temp - min_val) / (max_val - min_val);
      dev_hr := (dev_hr - min_val) / (max_val - min_val);
      dev_abpd := (dev_abpd - min_val) / (max_val - min_val);
      dev_abps := (dev_abps - min_val) / (max_val - min_val);
      
      weight_sum := dev_ox + dev_temp + dev_hr + dev_abpd + dev_abps;
      weighted_average := (oximeter * dev_ox) + (temperature * dev_temp) + (heartRate * dev_hr) + (abpd * dev_abpd)  + (abps * dev_abps);
      overall_risk := weighted_average/weight_sum;
    else
      overall_risk := average;
    end if;
end DataFuse;
