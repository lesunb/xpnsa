block Transition
  Modelica.Blocks.Interfaces.RealInput measurement annotation(
    Placement(visible = true, transformation(origin = {-120, -2}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-22, 20}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput sensor_up annotation(
    Placement(visible = true, transformation(origin = {-112, -52}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-19, -55}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.Blocks.Logical.And and1 annotation(
    Placement(visible = true, transformation(origin = {-13, -43}, extent = {{13, -13}, {-13, 13}}, rotation = -180)));
  Modelica.Blocks.Discrete.TriggeredSampler triggeredSampler annotation(
    Placement(visible = true, transformation(origin = {42, -2}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Delay delay(delayTime = 0.01) annotation(
    Placement(visible = true, transformation(origin = {-64, -28}, extent = {{8, -8}, {-8, 8}}, rotation = -180)));
  Modelica.Blocks.Interfaces.BooleanInput sig_transition_in annotation(
    Placement(visible = true, transformation(origin = {-112, -28}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-19, -33}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
    Placement(visible = true, transformation(origin = {110, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {16, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_transition_out annotation(
    Placement(visible = true, transformation(origin = {111, -43}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {16, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(delay.y, and1.u2) annotation(
    Line(points = {{-55, -28}, {-41, -28}, {-41, -33}, {-29, -33}}, color = {255, 0, 255}));
  connect(measurement, triggeredSampler.u) annotation(
    Line(points = {{-120, -2}, {28, -2}}, color = {0, 0, 127}));
  connect(sig_transition_in, delay.u) annotation(
    Line(points = {{-112, -28}, {-73, -28}}, color = {255, 0, 255}));
  connect(sensor_up, and1.u1) annotation(
    Line(points = {{-112, -52}, {-62, -52}, {-62, -43}, {-29, -43}}, color = {255, 0, 255}));
  connect(and1.y, triggeredSampler.trigger) annotation(
    Line(points = {{1, -43}, {42, -43}, {42, -16}}, color = {255, 0, 255}));
  connect(triggeredSampler.y, y) annotation(
    Line(points = {{56, -2}, {110, -2}}, color = {0, 0, 127}));
  connect(and1.y, sig_transition_out) annotation(
    Line(points = {{1, -43}, {111, -43}}, color = {255, 0, 255}));
protected
  annotation(
    Icon(graphics = {Rectangle( origin = {-2, -11},fillPattern = FillPattern.Solid, extent = {{-8, 69}, {8, -69}}), Text(origin = {-4, 76}, extent = {{52, -20}, {-52, 20}}, textString = "%name")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    uses(Modelica(version = "4.0.0")),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end Transition;
