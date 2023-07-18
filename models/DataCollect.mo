block DataCollect
  Modelica.Blocks.Interfaces.RealInput measurement annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-72, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput sensor_up annotation(
    Placement(visible = true, transformation(origin = {-110, -56}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-69, -53}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.Blocks.Discrete.TriggeredSampler triggeredSampler annotation(
    Placement(visible = true, transformation(origin = {-48, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.And and1 annotation(
    Placement(visible = true, transformation(origin = {-55, -15}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Frequency annotation(
    Placement(visible = true, transformation(origin = {-110, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-69, -33}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  TriggerToPulse triggerToPulse(Twidth = 0.01) annotation(
    Placement(visible = true, transformation(origin = {-31, -15}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  FrequencyTrigger frequencyTrigger annotation(
    Placement(visible = true, transformation(origin = {-77, -15}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_collected(start = false) annotation(
    Placement(visible = true, transformation(origin = {111, -15}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {70, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
    Placement(visible = true, transformation(origin = {110, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {75, 25}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
equation
//sig_processed = process.sig_processed;
//and13.y;
//sig_transfered = and14.y;
  connect(measurement, triggeredSampler.u) annotation(
    Line(points = {{-120, 0}, {-74, 0}, {-74, 26}, {-60, 26}}, color = {0, 0, 127}));
  connect(and1.y, triggeredSampler.trigger) annotation(
    Line(points = {{-49.5, -15}, {-48, -15}, {-48, 14}}, color = {255, 0, 255}));
  connect(and1.y, triggerToPulse.u) annotation(
    Line(points = {{-49.5, -15}, {-37, -15}}, color = {255, 0, 255}));
  connect(frequencyTrigger.trigger, and1.u1) annotation(
    Line(points = {{-67, -15}, {-61, -15}}, color = {255, 0, 255}));
  connect(Frequency, frequencyTrigger.frequency) annotation(
    Line(points = {{-110, -28}, {-96, -28}, {-96, -15}, {-88, -15}}, color = {0, 0, 127}));
  connect(sensor_up, and1.u2) annotation(
    Line(points = {{-110, -56}, {-66, -56}, {-66, -18}, {-60, -18}}, color = {255, 0, 255}));
  connect(triggeredSampler.y, y) annotation(
    Line(points = {{-36, 26}, {110, 26}}, color = {0, 0, 127}));
  connect(triggerToPulse.y, sig_collected) annotation(
    Line(points = {{-25, -15}, {111, -15}}, color = {255, 0, 255}));
protected
  annotation(
    Icon(graphics = {Rectangle(fillColor = {255, 170, 0}, fillPattern = FillPattern.Solid, extent = {{-60, 60}, {60, -60}}), Text(origin = {-4, 76}, extent = {{52, -20}, {-52, 20}}, textString = "%name")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    uses(Modelica(version = "4.0.0")),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end DataCollect;
