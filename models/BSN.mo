model BSN
  inner Modelica.Blocks.Noise.GlobalSeed globalSeed(enableNoise = true, fixedSeed = 0, useAutomaticSeed = false) annotation(
    Placement(visible = true, transformation(extent = {{76, 6}, {96, 26}}, rotation = 0)));
  Sensor Oximeter(HighRisk0_lb = 0, HighRisk0_lb_pct = 66, HighRisk0_ub = 90, HighRisk0_ub_pct = 100, HighRisk1_lb = -1, HighRisk1_ub = -1, LowRisk_lb = 95, LowRisk_lb_pct = 0, LowRisk_ub = 100, LowRisk_ub_pct = 20, MidRisk0_lb = 90, MidRisk0_lb_pct = 21, MidRisk0_ub = 95, MidRisk0_ub_pct = 65, MidRisk1_lb = -1, MidRisk1_ub = -1, battery_gain = 11000, sig_collected(start = false)) annotation(
    Placement(visible = true, transformation(origin = {56, -70}, extent = {{-24, -24}, {24, 24}}, rotation = 90)));
  Modelica.Blocks.Sources.CombiTimeTable sensor_measurements(columns = {2, 3, 4, 5, 6}, fileName = "C:/Users/araujo/Downloads/patient_0.txt", shiftTime = 1, tableName = "measurement", tableOnFile = true, verboseExtrapolation = true, verboseRead = true) annotation(
    Placement(visible = true, transformation(origin = {-152, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanConstant Charger(k = true) annotation(
    Placement(visible = true, transformation(origin = {-37, 3}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  CentralHub centralHub annotation(
    Placement(visible = true, transformation(origin = {0, 4.66294e-15}, extent = {{38, -38}, {-38, 38}}, rotation = 0)));
  Modelica.Blocks.Interaction.Show.BooleanValue Emergency annotation(
    Placement(visible = true, transformation(origin = {0, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Sensor temperature(HighRisk0_lb = 34.99999999, HighRisk0_lb_pct = 66, HighRisk0_ub = 0, HighRisk0_ub_pct = 100, HighRisk1_lb = 38.30000001, HighRisk1_ub = 50, LowRisk_lb = 36.5, LowRisk_lb_pct = 0, LowRisk_ub = 37.5, LowRisk_ub_pct = 20, MidRisk0_lb = 35, MidRisk0_lb_pct = 21, MidRisk0_ub = 36.49999999, MidRisk0_ub_pct = 65, MidRisk1_lb = 37.5000001, MidRisk1_ub = 38.3, battery_gain = 17000, sig_collected(start = false)) annotation(
    Placement(visible = true, transformation(origin = {-70, -70}, extent = {{-24, -24}, {24, 24}}, rotation = 90)));
  Modelica.Blocks.Sources.BooleanConstant charger_temp(k = false) annotation(
    Placement(visible = true, transformation(origin = {-46, -82}, extent = {{4, -4}, {-4, 4}}, rotation = -90)));
  Modelica.Blocks.Sources.BooleanConstant charger_ox(k = false) annotation(
    Placement(visible = true, transformation(origin = {88, -82}, extent = {{4, -4}, {-4, 4}}, rotation = -90)));
  Sensor HeartRate(HighRisk0_lb = 0, HighRisk0_lb_pct = 66, HighRisk0_ub = 70, HighRisk0_ub_pct = 100, HighRisk1_lb = 115, HighRisk1_ub = 300, LowRisk_lb = 85, LowRisk_lb_pct = 0, LowRisk_ub = 97, LowRisk_ub_pct = 20, MidRisk0_lb = 70, MidRisk0_lb_pct = 21, MidRisk0_ub = 85, MidRisk0_ub_pct = 65, MidRisk1_lb = 97, MidRisk1_ub = 115, battery_gain = 8000, sig_collected(start = false)) annotation(
    Placement(visible = true, transformation(origin = {-6, -70}, extent = {{-24, -24}, {24, 24}}, rotation = 90)));
  Modelica.Blocks.Sources.BooleanConstant charger_hr(k = false) annotation(
    Placement(visible = true, transformation(origin = {24, -82}, extent = {{4, -4}, {-4, 4}}, rotation = -90)));
  Sensor Abpd(HighRisk0_lb = -1, HighRisk0_lb_pct = 66, HighRisk0_ub = -1, HighRisk0_ub_pct = 100, HighRisk1_lb = 90, HighRisk1_ub = 300, LowRisk_lb = 0, LowRisk_lb_pct = 0, LowRisk_ub = 80, LowRisk_ub_pct = 20, MidRisk0_lb = -1, MidRisk0_lb_pct = 21, MidRisk0_ub = -1, MidRisk0_ub_pct = 65, MidRisk1_lb = 80, MidRisk1_ub = 90, battery_gain = 15000) annotation(
    Placement(visible = true, transformation(origin = {-70, 74}, extent = {{-24, 24}, {24, -24}}, rotation = -90)));
  Modelica.Blocks.Sources.BooleanConstant charger_abpd(k = false) annotation(
    Placement(visible = true, transformation(origin = {-44, 86}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  Modelica.Blocks.Sources.BooleanConstant charger_abps(k = false) annotation(
    Placement(visible = true, transformation(origin = {90, 86}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  Sensor Abps(HighRisk0_lb = -1, HighRisk0_lb_pct = 66, HighRisk0_ub = -1, HighRisk0_ub_pct = 100, HighRisk1_lb = 140, HighRisk1_ub = 300, LowRisk_lb = 0, LowRisk_lb_pct = 0, LowRisk_ub = 120, LowRisk_ub_pct = 20, MidRisk0_lb = -1, MidRisk0_lb_pct = 21, MidRisk0_ub = -1, MidRisk0_ub_pct = 65, MidRisk1_lb = 120, MidRisk1_ub = 140, battery_gain = 15000) annotation(
    Placement(visible = true, transformation(origin = {64, 74}, extent = {{-24, 24}, {24, -24}}, rotation = -90)));
  CollectedProcessedObs collectedProcessedObs_temp annotation(
    Placement(visible = true, transformation(origin = {-40, -58}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  CollectedProcessedObs collectedProcessedObs_ox annotation(
    Placement(visible = true, transformation(origin = {84, -58}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  CollectedProcessedObs collectedProcessedObs_abpd annotation(
    Placement(visible = true, transformation(origin = {-38, 62}, extent = {{-4, 4}, {4, -4}}, rotation = 0)));
  CollectedProcessedObs collectedProcessedObs_abps annotation(
    Placement(visible = true, transformation(origin = {90, 62}, extent = {{-4, 4}, {4, -4}}, rotation = 0)));
  CollectedProcessedObs collectedProcessedObs_hr annotation(
    Placement(visible = true, transformation(origin = {22, -58}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression fixedFrequency(y = 2.5) annotation(
    Placement(visible = true, transformation(origin = {-122, -108}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  RandomUniformBoolean hr_ctx annotation(
    Placement(visible = true, transformation(origin = {6, -122}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
  RandomUniformBoolean ox_ctx annotation(
    Placement(visible = true, transformation(origin = {68, -122}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
  RandomUniformBoolean abpd_ctx annotation(
    Placement(visible = true, transformation(origin = {-58, 114}, extent = {{6, -6}, {-6, 6}}, rotation = 90)));
  RandomUniformBoolean abps_ctx annotation(
    Placement(visible = true, transformation(origin = {76, 114}, extent = {{6, -6}, {-6, 6}}, rotation = 90)));
  RandomUniformBoolean temp_ctx annotation(
    Placement(visible = true, transformation(origin = {-58, -122}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
equation
  connect(centralHub.sig_emergency, Emergency.activePort) annotation(
    Line(points = {{0, 24}, {0, 34.5}}, color = {255, 0, 255}));
//connect(centralHub.sig_processed, battery_observer.sig_centralhub_processed) annotation(
//Line(points = {{0, -23}, {0, -36}, {-56, -36}, {-56, -45}, {-45, -45}}, color = {255, 0, 255}));
//connect(Oximeter.sig_collected, battery_observer.sig_sensor_collected) annotation(
//Line(points = {{-60, -34}, {-58, -34}, {-58, -49}, {-45, -49}}, color = {255, 0, 255}));
  connect(sensor_measurements.y[2], temperature.measurement) annotation(
    Line(points = {{-141, -96}, {-70, -96}, {-70, -87}}, color = {0, 0, 127}));
  connect(Oximeter.risk_pct, centralHub.oximeter_risk_pct) annotation(
    Line(points = {{56, -53}, {56, -48}, {32, -48}, {32, -40}}, color = {0, 0, 127}));
  connect(Oximeter.sig_transfered, centralHub.oximeter_sig_transfered) annotation(
    Line(points = {{64, -55}, {64, -46}, {37, -46}, {37, -40}}, color = {255, 0, 255}));
  connect(sensor_measurements.y[1], Oximeter.measurement) annotation(
    Line(points = {{-141, -96}, {56, -96}, {56, -87}}, color = {0, 0, 127}));
  connect(temperature.risk_pct, centralHub.temperature_risk_pct) annotation(
    Line(points = {{-70, -54}, {-70, -46}, {-37, -46}, {-37, -40}}, color = {0, 0, 127}));
  connect(temperature.sig_transfered, centralHub.temperature_sig_transfered) annotation(
    Line(points = {{-62, -54}, {-62, -48}, {-32, -48}, {-32, -40}}, color = {255, 0, 255}));
  connect(charger_temp.y, temperature.Recharge) annotation(
    Line(points = {{-46, -78}, {-46, -70}, {-54, -70}}, color = {255, 0, 255}));
  connect(charger_ox.y, Oximeter.Recharge) annotation(
    Line(points = {{88, -78}, {88, -70}, {72, -70}}, color = {255, 0, 255}));
  connect(Charger.y, centralHub.recharge) annotation(
    Line(points = {{-34, 3}, {-24, 3}}, color = {255, 0, 255}));
  connect(charger_hr.y, HeartRate.Recharge) annotation(
    Line(points = {{24, -78}, {24, -70}, {10, -70}}, color = {255, 0, 255}));
  connect(HeartRate.risk_pct, centralHub.heartRate_risk_pct) annotation(
    Line(points = {{-6, -53}, {-6, -46.5}, {-3, -46.5}, {-3, -40}}, color = {0, 0, 127}));
  connect(HeartRate.sig_transfered, centralHub.heartRate_sig_transfered) annotation(
    Line(points = {{2, -55}, {2, -40}}, color = {255, 0, 255}));
  connect(sensor_measurements.y[3], HeartRate.measurement) annotation(
    Line(points = {{-141, -96}, {-6, -96}, {-6, -87}}, color = {0, 0, 127}));
  connect(charger_abpd.y, Abpd.Recharge) annotation(
    Line(points = {{-44, 82}, {-44, 74}, {-54, 74}}, color = {255, 0, 255}));
  connect(sensor_measurements.y[4], Abpd.measurement) annotation(
    Line(points = {{-141, -96}, {-102, -96}, {-102, 102}, {-70, 102}, {-70, 92}}, color = {0, 0, 127}));
  connect(charger_abps.y, Abps.Recharge) annotation(
    Line(points = {{90, 82}, {90, 74}, {80, 74}}, color = {255, 0, 255}));
  connect(sensor_measurements.y[5], Abps.measurement) annotation(
    Line(points = {{-141, -96}, {-102, -96}, {-102, 102}, {64, 102}, {64, 92}}, color = {0, 0, 127}));
  connect(Abpd.risk_pct, centralHub.abpd_risk_pct) annotation(
    Line(points = {{-70, 58}, {-70, 48}, {-37, 48}, {-37, 40}}, color = {0, 0, 127}));
  connect(Abpd.sig_transfered, centralHub.abpd_sig_transfered) annotation(
    Line(points = {{-62, 58}, {-62, 50}, {-32, 50}, {-32, 40}}, color = {255, 0, 255}));
  connect(Abps.risk_pct, centralHub.abps_risk_pct) annotation(
    Line(points = {{64, 58}, {64, 48}, {32, 48}, {32, 40}}, color = {0, 0, 127}));
  connect(Abps.sig_transfered, centralHub.abps_sig_transfered) annotation(
    Line(points = {{72, 58}, {72, 46}, {37, 46}, {37, 40}}, color = {255, 0, 255}));
  connect(temperature.sig_collected, collectedProcessedObs_temp.sig_sensor_collected) annotation(
    Line(points = {{-56, -54}, {-53, -54}, {-53, -59}, {-44, -59}}, color = {255, 0, 255}));
  connect(Oximeter.sig_collected, collectedProcessedObs_ox.sig_sensor_collected) annotation(
    Line(points = {{69, -55}, {74.75, -55}, {74.75, -59}, {80, -59}}, color = {255, 0, 255}));
  connect(centralHub.sig_processed, collectedProcessedObs_temp.sig_centralhub_processed) annotation(
    Line(points = {{-24, -3}, {-48, -3}, {-48, -57}, {-44, -57}}, color = {255, 0, 255}));
  connect(HeartRate.sig_collected, collectedProcessedObs_hr.sig_sensor_collected) annotation(
    Line(points = {{7, -55}, {13, -55}, {13, -59}, {18, -59}}, color = {255, 0, 255}));
  connect(centralHub.sig_processed, collectedProcessedObs_hr.sig_centralhub_processed) annotation(
    Line(points = {{-24, -4}, {-48, -4}, {-48, -50}, {14, -50}, {14, -57}, {18, -57}}, color = {255, 0, 255}));
  connect(centralHub.sig_processed, collectedProcessedObs_ox.sig_centralhub_processed) annotation(
    Line(points = {{-24, -4}, {-48, -4}, {-48, -50}, {76, -50}, {76, -57}, {80, -57}}, color = {255, 0, 255}));
  connect(Abpd.sig_collected, collectedProcessedObs_abpd.sig_sensor_collected) annotation(
    Line(points = {{-56, 58}, {-56, 56}, {-48, 56}, {-48, 63}, {-42, 63}}, color = {255, 0, 255}));
  connect(centralHub.sig_processed, collectedProcessedObs_abpd.sig_centralhub_processed) annotation(
    Line(points = {{-24, -4}, {-48, -4}, {-48, 54}, {-46, 54}, {-46, 61}, {-42, 61}}, color = {255, 0, 255}));
  connect(Abps.sig_collected, collectedProcessedObs_abps.sig_sensor_collected) annotation(
    Line(points = {{78, 58}, {78, 56}, {80, 56}, {80, 63}, {86, 63}}, color = {255, 0, 255}));
  connect(centralHub.sig_processed, collectedProcessedObs_abps.sig_centralhub_processed) annotation(
    Line(points = {{-24, -4}, {-48, -4}, {-48, 54}, {82, 54}, {82, 61}, {86, 61}}, color = {255, 0, 255}));
  connect(fixedFrequency.y, temperature.Frequency) annotation(
    Line(points = {{-111, -108}, {-62, -108}, {-62, -86}}, color = {0, 0, 127}));
  connect(fixedFrequency.y, HeartRate.Frequency) annotation(
    Line(points = {{-111, -108}, {2, -108}, {2, -86}}, color = {0, 0, 127}));
  connect(fixedFrequency.y, Oximeter.Frequency) annotation(
    Line(points = {{-111, -108}, {64, -108}, {64, -86}}, color = {0, 0, 127}));
  connect(fixedFrequency.y, Abpd.Frequency) annotation(
    Line(points = {{-111, -108}, {-94, -108}, {-94, 98}, {-62, 98}, {-62, 90}}, color = {0, 0, 127}));
  connect(fixedFrequency.y, Abps.Frequency) annotation(
    Line(points = {{-111, -108}, {-94, -108}, {-94, 98}, {72, 98}, {72, 90}}, color = {0, 0, 127}));
  connect(hr_ctx.y, HeartRate.context) annotation(
    Line(points = {{6, -115}, {6, -86}}, color = {255, 0, 255}));
  connect(ox_ctx.y, Oximeter.context) annotation(
    Line(points = {{68, -115}, {68, -86}}, color = {255, 0, 255}));
  connect(abpd_ctx.y, Abpd.context) annotation(
    Line(points = {{-58, 107}, {-58, 90}}, color = {255, 0, 255}));
  connect(abps_ctx.y, Abps.context) annotation(
    Line(points = {{76, 107}, {76, 90}}, color = {255, 0, 255}));
  connect(temp_ctx.y, temperature.context) annotation(
    Line(points = {{-58, -116}, {-58, -86}}, color = {255, 0, 255}));
protected
  annotation(
    uses(Modelica(version = "4.0.0")));
end BSN;
