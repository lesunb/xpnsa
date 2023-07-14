block RandomUniformBooleanSignal
  Modelica.Blocks.Noise.TruncatedNormalNoise TruncatedNormalNoise(samplePeriod = 1, useAutomaticLocalSeed = true, useGlobalSeed = true, y_max = 1, y_min = 0) annotation(
    Placement(visible = true, transformation(origin = {-81, -2.22045e-16}, extent = {{-15, -14}, {15, 14}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanExpression BooleanExpression(y = triggeredSampler.y >= threshold) annotation(
    Placement(visible = true, transformation(origin = {22, 2.22045e-16}, extent = {{-32, -16}, {32, 16}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput y annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput u annotation(
    Placement(visible = true, transformation(origin = {-40, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {-112, -2.22045e-16}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Blocks.Discrete.TriggeredSampler triggeredSampler annotation(
    Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Real threshold = 0.1;
equation
  connect(BooleanExpression.y, y) annotation(
    Line(points = {{57, 0}, {110, 0}}, color = {255, 0, 255}));
  connect(TruncatedNormalNoise.y, triggeredSampler.u) annotation(
    Line(points = {{-64, 0}, {-52, 0}}, color = {0, 0, 127}));
  connect(u, triggeredSampler.trigger) annotation(
    Line(points = {{-40, -100}, {-40, -12}}, color = {255, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Text(origin = {-8, 125}, extent = {{-92, 33}, {92, -33}}, textString = "%name"), Text(origin = {2, 3}, extent = {{-92, 113}, {92, -113}}, textString = "?"), Rectangle(extent = {{-100, 100}, {100, -100}})}));
end RandomUniformBooleanSignal;
