function Detect_risk
  input Real risk;
  output Real patient_risk;
algorithm
  if risk <= 20 then
    patient_risk := 0;
  elseif risk > 20 and risk <= 40 then
    patient_risk := 1;
  elseif risk > 40 and risk <= 60 then
    patient_risk := 2;
  elseif risk > 60 and risk <= 80 then
    patient_risk := 3;
  else
    patient_risk := 4;
  end if;
end Detect_risk;
