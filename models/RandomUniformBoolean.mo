block RandomUniformBoolean
  Modelica.Blocks.Noise.TruncatedNormalNoise TruncatedNormalNoise(samplePeriod = 1, useAutomaticLocalSeed = true, useGlobalSeed = true, y_max = 1, y_min = 0) annotation(
    Placement(visible = true, transformation(origin = {-48, -1}, extent = {{-16, -15}, {16, 15}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanExpression BooleanExpression(y = TruncatedNormalNoise.y >= 0.3) annotation(
    Placement(visible = true, transformation(origin = {22, 2.22045e-16}, extent = {{-32, -16}, {32, 16}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput y annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(BooleanExpression.y, y) annotation(
    Line(points = {{57, 0}, {110, 0}}, color = {255, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Text(origin = {-8, 125}, extent = {{-92, 33}, {92, -33}}, textString = "%name"), Text(origin = {2, 3}, extent = {{-92, 113}, {92, -113}}, textString = "?"), Rectangle(extent = {{-100, 100}, {100, -100}})}));
end RandomUniformBoolean;
