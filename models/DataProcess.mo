block DataProcess
  parameter Real LowRisk_lb, LowRisk_ub;
  parameter Real MidRisk0_lb, MidRisk0_ub;
  parameter Real HighRisk0_lb, HighRisk0_ub;
  parameter Real MidRisk1_lb, MidRisk1_ub;
  parameter Real HighRisk1_lb, HighRisk1_ub;
  parameter Real LowRisk_lb_pct, LowRisk_ub_pct;
  parameter Real MidRisk0_lb_pct, MidRisk0_ub_pct;
  parameter Real HighRisk0_lb_pct, HighRisk0_ub_pct;
  parameter Real p_delayTime = 0.1;
  parameter Real weight_old_value = 0.8;
  parameter Real weight_new_value = 0.2;
  //parameter Integer delay_k = 1;
  Modelica.Blocks.Interfaces.RealInput u annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
    Placement(visible = true, transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput sig_collected annotation(
    Placement(visible = true, transformation(origin = {-100, -32}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-70, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_processed annotation(
    Placement(visible = true, transformation(origin = {70, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Modelica.Units.SI.Duration delayMax(min = 0.5, start = 1) "Maximum delay time";
  RandomUniformValueSignal randomUniformValueSignal(gain = 1,y_max = 1, y_min = 0.1)  annotation(
    Placement(visible = true, transformation(origin = {-37, -51}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  
protected
  Boolean processed = if edge(sig_collected) then true else false;
  Real value;
  Real delay_k = if randomUniformValueSignal.y <= 0 then 0.1 else randomUniformValueSignal.y; // Fixing error when initializes as zero.
  Real sig_value = if sig_collected then 1 else 0;
equation
  value = calc_risk_pct(measurement = u, LowRisk_lb = LowRisk_lb, LowRisk_ub = LowRisk_ub, MidRisk0_lb = MidRisk0_lb, MidRisk0_ub = MidRisk0_ub, HighRisk0_lb = HighRisk0_lb, HighRisk0_ub = HighRisk0_ub, MidRisk1_lb = MidRisk1_lb, MidRisk1_ub = MidRisk1_ub, HighRisk1_lb = HighRisk1_lb, HighRisk1_ub = HighRisk1_ub, LowRisk_lb_pct = LowRisk_lb_pct, LowRisk_ub_pct = LowRisk_ub_pct, MidRisk0_lb_pct = MidRisk0_lb_pct, MidRisk0_ub_pct = MidRisk0_ub_pct, HighRisk0_lb_pct = HighRisk0_lb_pct, HighRisk0_ub_pct = HighRisk0_ub_pct);
  y = delay(value, randomUniformValueSignal.y, delayMax);
  sig_processed = delay(sig_value, randomUniformValueSignal.y, delayMax) >= 0.5;
  connect(sig_collected, randomUniformValueSignal.u) annotation(
    Line(points = {{-100, -32}, {-54, -32}, {-54, -51}, {-45, -51}}, color = {255, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Rectangle(origin = {0, -20}, fillColor = {85, 0, 255}, fillPattern = FillPattern.CrossDiag, extent = {{-60, 60}, {60, -60}}), Text(origin = {-3, 56}, extent = {{-63, 20}, {63, -20}}, textString = "%name")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end DataProcess;
