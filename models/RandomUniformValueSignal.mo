block RandomUniformValueSignal
  Modelica.Blocks.Noise.TruncatedNormalNoise TruncatedNormalNoise(samplePeriod = 1, useAutomaticLocalSeed = true, useGlobalSeed = true, y_max = y_max, y_min = y_min) annotation(
    Placement(visible = true, transformation(origin = {-61, -2.22045e-16}, extent = {{-15, -14}, {15, 14}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput u annotation(
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {-112, -2.22045e-16}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Blocks.Discrete.TriggeredSampler triggeredSampler annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Real threshold = 0.1;
  parameter Integer gain = 1;
  parameter Real y_min(start=0) "Lower limit of y" annotation(Dialog(enable=enableNoise));
  parameter Real y_max(start=1) "Upper limit of y" annotation(Dialog(enable=enableNoise));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression(y = gain)  annotation(
    Placement(visible = true, transformation(origin = {18, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.MultiProduct multiProduct(nu = 2)  annotation(
    Placement(visible = true, transformation(origin = {62, 0}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
equation
  connect(TruncatedNormalNoise.y, triggeredSampler.u) annotation(
    Line(points = {{-44.5, 0}, {-18.5, 0}, {-18.5, -2.22045e-16}, {-12.5, -2.22045e-16}}, color = {0, 0, 127}));
  connect(u, triggeredSampler.trigger) annotation(
    Line(points = {{0, -100}, {0, -12}}, color = {255, 0, 255}));
  connect(realExpression.y, multiProduct.u[1]) annotation(
    Line(points = {{30, -40}, {42, -40}, {42, 0}, {56, 0}}, color = {0, 0, 127}));
  connect(triggeredSampler.y, multiProduct.u[2]) annotation(
    Line(points = {{12, 0}, {56, 0}}, color = {0, 0, 127}));
  connect(multiProduct.y, y) annotation(
    Line(points = {{70, 0}, {110, 0}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Text(origin = {-8, 125}, extent = {{-92, 33}, {92, -33}}, textString = "%name"), Text(origin = {2, 3}, extent = {{-92, 113}, {92, -113}}, textString = "?"), Rectangle(extent = {{-100, 100}, {100, -100}})}));
end RandomUniformValueSignal;
