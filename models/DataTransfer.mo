block DataTransfer
  Modelica.Blocks.Interfaces.BooleanInput signal annotation(
    Placement(visible = true, transformation(origin = {-120, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-111, -31}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput context annotation(
    Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-111, -69}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput input_value annotation(
    Placement(visible = true, transformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-112, 50}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Transfer transfer annotation(
    Placement(visible = true, transformation(origin = {-8, 14}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  Modelica.Blocks.Logical.And and1 annotation(
    Placement(visible = true, transformation(origin = {45, -1}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
    Placement(visible = true, transformation(origin = {110, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_transfered annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Discrete.TriggeredSampler triggeredSampler annotation(
    Placement(visible = true, transformation(origin = {74, 14}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
equation
  connect(input_value, transfer.u) annotation(
    Line(points = {{-120, 40}, {-62, 40}, {-62, 14}, {-30, 14}}, color = {0, 0, 127}));
  connect(signal, transfer.sig_processed) annotation(
    Line(points = {{-120, -20}, {-60, -20}, {-60, -2}, {-30, -2}}, color = {255, 0, 255}));
  connect(transfer.sig_transfered, and1.u1) annotation(
    Line(points = {{13, -1}, {37, -1}}, color = {255, 0, 255}));
  connect(context, and1.u2) annotation(
    Line(points = {{-120, -60}, {26, -60}, {26, -7}, {37, -7}}, color = {255, 0, 255}));
  connect(and1.y, sig_transfered) annotation(
    Line(points = {{52, 0}, {110, 0}}, color = {255, 0, 255}));
  connect(and1.y, triggeredSampler.trigger) annotation(
    Line(points = {{52, 0}, {74, 0}, {74, 5}}, color = {255, 0, 255}));
  connect(transfer.y, triggeredSampler.u) annotation(
    Line(points = {{14, 14}, {64, 14}}, color = {0, 0, 127}));
  connect(triggeredSampler.y, y) annotation(
    Line(points = {{82, 14}, {110, 14}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Rectangle(fillColor = {85, 85, 255}, fillPattern = FillPattern.Vertical, extent = {{-100, 100}, {100, -100}}), Text(origin = {-4, 126}, extent = {{-98, 32}, {98, -32}}, textString = "%name")}));
end DataTransfer;
