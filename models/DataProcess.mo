block DataProcess
  Process process annotation(
    Placement(visible = true, transformation(origin = {-24, 16}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
    Placement(visible = true, transformation(origin = {110, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_processed annotation(
    Placement(visible = true, transformation(origin = {111, 1}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput input_value annotation(
    Placement(visible = true, transformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-112, 50}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput signal annotation(
    Placement(visible = true, transformation(origin = {-120, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-111, -31}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
equation
  connect(input_value, process.u) annotation(
    Line(points = {{-120, 40}, {-76, 40}, {-76, 16}, {-44, 16}}, color = {0, 0, 127}));
  connect(signal, process.sig_collected) annotation(
    Line(points = {{-120, -20}, {-84, -20}, {-84, 0}, {-44, 0}}, color = {255, 0, 255}));
  connect(process.y, y) annotation(
    Line(points = {{-2, 16}, {110, 16}}, color = {0, 0, 127}));
  connect(process.sig_processed, sig_processed) annotation(
    Line(points = {{-2, 0}, {112, 0}}, color = {255, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Rectangle(fillColor = {255, 85, 127}, fillPattern = FillPattern.Vertical, extent = {{-100, 100}, {100, -100}}), Text(origin = {-4, 126}, extent = {{-98, 32}, {98, -32}}, textString = "%name")}));
end DataProcess;
