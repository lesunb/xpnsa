block Battery
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {14, -48}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  parameter Real recharge_level = 0.1 "Indicates the lowest allowed charge";
  parameter Integer gain_k = 10000 "Maximum gain allowed for battery consumption";
  parameter Real recharged_level = 0.99 "Indicates the battery level for when it should stop recharging";
  parameter Modelica.Electrical.Batteries.ParameterRecords.CellData cellData(Idis = 0.8, OCVmax = 4.2, OCVmin = 2.5, Qnom = 18000, Ri = cellData.OCVmax / 1200)  annotation(
    Placement(visible = true, transformation(origin = {82, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Batteries.BatteryStacksWithSensors.Cell cell(SOC0 = 1, cellData = cellData)  annotation(
    Placement(visible = true, transformation(origin = {46, 2}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent annotation(
    Placement(visible = true, transformation(origin = {14, 0}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.BooleanOutput SIG_BATTERY_ON(start = true) annotation(
    Placement(visible = true, transformation(origin = {68, 54}, extent = {{4, -4}, {-4, 4}}, rotation = 180), iconTransformation(origin = {-124, 4.44089e-16}, extent = {{-8, -8}, {8, 8}}, rotation = 180)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal annotation(
    Placement(visible = true, transformation(origin = {-48, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput u annotation(
    Placement(visible = true, transformation(origin = {-100, 6}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {120, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch1 annotation(
    Placement(visible = true, transformation(origin = {68, -22}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch annotation(
    Placement(visible = true, transformation(origin = {68, 24}, extent = {{-4, 4}, {4, -4}}, rotation = 0)));
  Modelica.Electrical.Batteries.Utilities.CCCVcharger cccvCharger(I = 500, Vend = 10, rampTime = 1) annotation(
    Placement(visible = true, transformation(origin = {80, 0}, extent = {{6, 6}, {-6, -6}}, rotation = 90)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
    Placement(visible = true, transformation(origin = {80, -30}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Boolean is_recharging = pre(SIG_BATTERY_OFF);
  Boolean not_done = cell.SOC < recharged_level;
  Modelica.Blocks.Interfaces.BooleanOutput SIG_BATTERY_OFF(start = false) annotation(
    Placement(visible = true, transformation(origin = {68, 66}, extent = {{-4, 4}, {4, -4}}, rotation = 0), iconTransformation(origin = {-96, -42}, extent = {{4, 4}, {-4, -4}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput recharge(start = false)  annotation(
    Placement(visible = true, transformation(origin = {0, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -18}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  DynamicGain dynamicGain annotation(
    Placement(visible = true, transformation(origin = {-14, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  RandomUniformValueSignal randomUniformValueSignal(gain = gain_k, y_max = 3, y_min = 1)  annotation(
    Placement(visible = true, transformation(origin = {-47, -21}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
equation
  SIG_BATTERY_OFF = if cell.SOC < recharge_level then true elseif is_recharging and not_done then true else false;
  SIG_BATTERY_ON = if not SIG_BATTERY_OFF and cell.SOC >= recharge_level then true else false;
  connect(signalCurrent.n, ground.p) annotation(
    Line(points = {{14, -10}, {14, -40}}, color = {0, 0, 255}));
  connect(u, booleanToReal.u) annotation(
    Line(points = {{-100, 6}, {-60, 6}}, color = {255, 0, 255}));
  connect(ground1.p, switch1.p) annotation(
    Line(points = {{80, -22}, {64, -22}}, color = {0, 0, 255}));
  connect(cccvCharger.n, ground1.p) annotation(
    Line(points = {{80, -6}, {80, -22}}, color = {0, 0, 255}));
  connect(cccvCharger.p, switch.p) annotation(
    Line(points = {{80, 6}, {80, 24}, {64, 24}}, color = {0, 0, 255}));
  connect(switch.n, cell.p) annotation(
    Line(points = {{72, 24}, {46, 24}, {46, 12}}, color = {0, 0, 255}));
  connect(switch1.n, cell.n) annotation(
    Line(points = {{72, -22}, {46, -22}, {46, -8}}, color = {0, 0, 255}));
  connect(recharge, switch1.control) annotation(
    Line(points = {{0, 16}, {68, 16}, {68, -18}}, color = {255, 0, 255}));
  connect(cell.p, signalCurrent.p) annotation(
    Line(points = {{46, 12}, {46, 40}, {14, 40}, {14, 10}}, color = {0, 0, 255}));
  connect(ground.p, cell.n) annotation(
    Line(points = {{14, -40}, {46, -40}, {46, -8}}, color = {0, 0, 255}));
  connect(recharge, switch.control) annotation(
    Line(points = {{0, 16}, {68, 16}, {68, 20}}, color = {255, 0, 255}));
  connect(dynamicGain.y, signalCurrent.i) annotation(
    Line(points = {{-4, 0}, {2, 0}}, color = {0, 0, 127}));
  connect(booleanToReal.y, dynamicGain.u) annotation(
    Line(points = {{-37, 6}, {-26, 6}}, color = {0, 0, 127}));
  connect(u, randomUniformValueSignal.u) annotation(
    Line(points = {{-100, 6}, {-72, 6}, {-72, -21}, {-55, -21}}, color = {255, 0, 255}));
  connect(randomUniformValueSignal.y, dynamicGain.k) annotation(
    Line(points = {{-39, -21}, {-32, -21}, {-32, -4}, {-26, -4}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{70, -40}, {-70, 40}}), Rectangle(lineColor = {0, 0, 255}, extent = {{-90, 60}, {90, -60}}, radius = 10), Polygon(lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, points = {{-90, 30}, {-100, 30}, {-110, 10}, {-110, -10}, {-100, -30}, {-90, -30}, {-90, 30}}), Rectangle(lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{90, 40}, {110, -40}}), Text(origin = {-1, 3}, lineColor = {255, 255, 255}, extent = {{-67, 27}, {67, -27}}, textString = "%name")}));
end Battery;
