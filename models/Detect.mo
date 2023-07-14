block Detect
  Modelica.Blocks.Interfaces.RealInput risk annotation(
    Placement(visible = true, transformation(origin = {-88, 34}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-88, 8.88178e-16}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput patient_risk annotation(
    Placement(visible = true, transformation(origin = {70, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput signal annotation(
    Placement(visible = true, transformation(origin = {-86, -16}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-88, -48}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  TriggerToPulse triggerToPulse(Twidth = 0.01) annotation(
    Placement(visible = true, transformation(origin = {20, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Delay comp_delay(delayTime = p_delayTime) annotation(
    Placement(visible = true, transformation(origin = {-28, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_detected annotation(
    Placement(visible = true, transformation(origin = {66, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Real p_delayTime = 0.1;
  Modelica.Blocks.Interfaces.BooleanOutput emergency(start=false) annotation(
    Placement(visible = true, transformation(origin = {68, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  Boolean processed = if edge(signal) then true else false;
  Real value;
equation
  value = Detect_risk(risk);
  emergency = if value > 2.1 then true else false;
  patient_risk = delay(value, p_delayTime);
  connect(comp_delay.y, triggerToPulse.u) annotation(
    Line(points = {{-17, -16}, {13, -16}}, color = {255, 0, 255}));
  connect(triggerToPulse.y, sig_detected) annotation(
    Line(points = {{28, -16}, {66, -16}}, color = {255, 0, 255}));
  connect(signal, comp_delay.u) annotation(
    Line(points = {{-86, -16}, {-40, -16}}, color = {255, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Rectangle(origin = {2, 0}, fillColor = {0, 85, 0}, fillPattern = FillPattern.Backward, extent = {{-78, 60}, {78, -60}}), Text(origin = {-2, 84}, extent = {{-78, 26}, {78, -26}}, textString = "%name")}));
end Detect;
