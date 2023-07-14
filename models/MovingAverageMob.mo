block MovingAverageMob
  Modelica.Blocks.Interfaces.RealInput u annotation(
    Placement(visible = true, transformation(origin = {-120, -6}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Math.Add add annotation(
    Placement(visible = true, transformation(origin = {-12, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Real weight_old_value = 0.8;
  Modelica.Blocks.Math.Gain gain(k = weight_old_value)  annotation(
    Placement(visible = true, transformation(origin = {26, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
    Placement(visible = true, transformation(origin = {80, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Real weight_new_value = 0.2;
  Modelica.Blocks.Math.Gain gain1(k = weight_new_value) annotation(
    Placement(visible = true, transformation(origin = {-52, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput signal annotation(
    Placement(visible = true, transformation(origin = {52, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Discrete.TriggeredSampler triggeredSampler annotation(
    Placement(visible = true, transformation(origin = {52, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Discrete.TriggeredSampler triggeredSampler1 annotation(
    Placement(visible = true, transformation(origin = {0, -46}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
initial equation
  gain.u = u;
  add.u2 = u;
equation
  gain.u = delay(add.y, 0.001);
  connect(gain1.y, add.u1) annotation(
    Line(points = {{-41, -6}, {-25, -6}}, color = {0, 0, 127}));
  connect(triggeredSampler.y, y) annotation(
    Line(points = {{63, 46}, {80, 46}}, color = {0, 0, 127}));
  connect(add.y, triggeredSampler.u) annotation(
    Line(points = {{-1, -12}, {4, -12}, {4, 46}, {40, 46}}, color = {0, 0, 127}));
  connect(signal, triggeredSampler.trigger) annotation(
    Line(points = {{52, -120}, {52, 34}}, color = {255, 0, 255}));
  connect(gain.y, triggeredSampler1.u) annotation(
    Line(points = {{38, -12}, {44, -12}, {44, -46}, {12, -46}}, color = {0, 0, 127}));
  connect(triggeredSampler1.y, add.u2) annotation(
    Line(points = {{-10, -46}, {-36, -46}, {-36, -18}, {-24, -18}}, color = {0, 0, 127}));
  connect(signal, triggeredSampler1.trigger) annotation(
    Line(points = {{52, -120}, {52, -68}, {0, -68}, {0, -58}}, color = {255, 0, 255}));
  connect(u, gain1.u) annotation(
    Line(points = {{-120, -6}, {-64, -6}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Line(origin = {-0.74256, -7}, points = {{-84, 78}, {-84, -90}}, color = {192, 192, 192}), Rectangle(lineColor = {192, 192, 192}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Backward, extent = {{-84, -82}, {-18, 4}}), Polygon(lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, points = {{-84, 90}, {-92, 68}, {-76, 68}, {-84, 90}, {-84, 90}}), Line(origin = {-0.74256, -7}, points = {{-84, 30}, {-72, 30}, {-52, 28}, {-32, 20}, {-26, 16}, {-22, 12}, {-18, 6}, {-14, -4}, {-4, -46}, {0, -64}, {2, -82}}, color = {0, 0, 127}, smooth = Smooth.Bezier), Line(origin = {-0.74256, -7}, points = {{2, -82}, {4, -64}, {8, -56}, {12, -56}, {16, -60}, {18, -66}, {20, -82}}, color = {0, 0, 127}, smooth = Smooth.Bezier), Line(origin = {-0.74256, -7}, points = {{20, -80}, {20, -78}, {20, -72}, {22, -66}, {24, -64}, {28, -64}, {32, -66}, {34, -70}, {36, -78}, {36, -82}, {36, -74}, {38, -68}, {40, -66}, {44, -66}, {46, -68}, {48, -72}, {50, -78}, {50, -82}, {50, -78}, {52, -70}, {54, -68}, {58, -68}, {62, -72}, {64, -76}, {64, -78}, {64, -80}, {64, -82}}, color = {0, 0, 127}, smooth = Smooth.Bezier), Polygon(lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, points = {{90, -82}, {68, -74}, {68, -90}, {90, -82}}), Line(origin = {-0.74256, -7}, points = {{-90, -82}, {82, -82}}, color = {192, 192, 192}), Text(lineColor = {175, 175, 175}, extent = {{-26, 88}, {88, 48}}, textString = "MA")}));
end MovingAverageMob;
