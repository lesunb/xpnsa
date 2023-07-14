block Transfer
  Modelica.Blocks.Interfaces.RealInput u annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
    Placement(visible = true, transformation(origin = {98, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput sig_processed annotation(
    Placement(visible = true, transformation(origin = {-100, -32}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-70, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_transfered annotation(
    Placement(visible = true, transformation(origin = {98, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //parameter Real p_delayTime = 0.1;
  parameter Modelica.Units.SI.Duration delayMax(min = 0, start = 1) "Maximum delay time";
  RandomUniformBooleanSignal rand_transfer_failure(threshold = threshold_transfer_failure) annotation(
    Placement(visible = true, transformation(origin = {-58, -48}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  parameter Real threshold_transfer_failure = 0.1;
  Modelica.Blocks.Discrete.TriggeredSampler triggeredSampler annotation(
    Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.And and1 annotation(
    Placement(visible = true, transformation(origin = {-36, -32}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  RandomUniformValueSignal randomUniformValueSignal annotation(
    Placement(visible = true, transformation(origin = {0, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Discrete.TriggeredSampler triggeredSampler2 annotation(
    Placement(visible = true, transformation(origin = {48, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  Boolean processed = if edge(sig_processed) then true else false;
  Real sig_value = if and1.y then 1 else 0;
equation
  triggeredSampler2.u = delay(triggeredSampler.y, randomUniformValueSignal.y, delayMax);
  sig_transfered = delay(sig_value, randomUniformValueSignal.y, delayMax) >= 0.5;
//Nothing will be processed
  connect(u, triggeredSampler.u) annotation(
    Line(points = {{-100, 0}, {-32, 0}}, color = {0, 0, 127}));
  connect(sig_processed, rand_transfer_failure.u) annotation(
    Line(points = {{-100, -32}, {-68, -32}, {-68, -48}, {-65, -48}}, color = {255, 0, 255}));
  connect(rand_transfer_failure.y, and1.u2) annotation(
    Line(points = {{-51, -48}, {-48, -48}, {-48, -37}, {-43, -37}}, color = {255, 0, 255}));
  connect(sig_processed, and1.u1) annotation(
    Line(points = {{-100, -32}, {-43, -32}}, color = {255, 0, 255}));
  connect(and1.y, triggeredSampler.trigger) annotation(
    Line(points = {{-30, -32}, {-20, -32}, {-20, -12}}, color = {255, 0, 255}));
  connect(and1.y, randomUniformValueSignal.u) annotation(
    Line(points = {{-30, -32}, {-12, -32}}, color = {255, 0, 255}));
  connect(sig_transfered, triggeredSampler2.trigger);
  connect(triggeredSampler2.y, y) annotation(
    Line(points = {{60, 0}, {98, 0}}, color = {0, 0, 127}));
  annotation(
    Icon(graphics = {Rectangle(origin = {0, -20}, fillColor = {16, 124, 239}, fillPattern = FillPattern.Vertical, extent = {{-60, 60}, {60, -60}}), Text(origin = {0, 58}, extent = {{-88, 20}, {88, -20}}, textString = "%name")}),
    uses(Modelica(version = "4.0.0")));
end Transfer;
