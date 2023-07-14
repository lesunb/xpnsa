block CollectedProcessedObsFinal
  Modelica.Blocks.Interfaces.BooleanOutput s_collectedReached annotation(
    Placement(visible = true, transformation(origin = {36, -2}, extent = {{-4, -4}, {4, 4}}, rotation = -90), iconTransformation(origin = {109, 9}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput s_error annotation(
    Placement(visible = true, transformation(origin = {84, 8}, extent = {{-4, -4}, {4, 4}}, rotation = -90), iconTransformation(origin = {109, -9}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput sig_sensor_collected annotation(
    Placement(visible = true, transformation(origin = {12, -68}, extent = {{-12, -12}, {12, 12}}, rotation = 90), iconTransformation(origin = {-110, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput sig_centralhub_processed annotation(
    Placement(visible = true, transformation(origin = {-24, -68}, extent = {{-12, -12}, {12, 12}}, rotation = 90), iconTransformation(origin = {-110, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot annotation(
    Placement(visible = true, transformation(origin = {138, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanExpression SetBoolean1(y = timer.y > 2.5) annotation(
    Placement(visible = true, transformation(origin = {23, -31}, extent = {{-9, -5}, {9, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Timer timer annotation(
    Placement(visible = true, transformation(origin = {46, 10}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.StateGraph.StepWithSignal error(nIn = 1, nOut = 0) annotation(
    Placement(visible = true, transformation(origin = {84, 26}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.StateGraph.InitialStepWithSignal BatteryON(nIn = 2, nOut = 2) annotation(
    Placement(visible = true, transformation(origin = {-16, 26}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.StateGraph.StepWithSignal collectedReached(nIn = 1, nOut = 2) annotation(
    Placement(visible = true, transformation(origin = {36, 26}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.StateGraph.StepWithSignal BatteryOff(nIn = 1, nOut = 1) annotation(
    Placement(visible = true, transformation(origin = {-74, 26}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput s_batteryOn annotation(
    Placement(visible = true, transformation(origin = {-16, 6}, extent = {{-4, -4}, {4, 4}}, rotation = -90), iconTransformation(origin = {109, -27}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.Blocks.Logical.Not not1 annotation(
    Placement(visible = true, transformation(origin = {-46, -26}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput s_batteryOff annotation(
    Placement(visible = true, transformation(origin = {-74, 6}, extent = {{-4, -4}, {4, 4}}, rotation = -90), iconTransformation(origin = {109, 27}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.StateGraph.TransitionWithSignal t5 annotation(
    Placement(visible = true, transformation(origin = {-40, 74}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.StateGraph.TransitionWithSignal t3 annotation(
    Placement(visible = true, transformation(origin = {62, 26}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.StateGraph.TransitionWithSignal t4 annotation(
    Placement(visible = true, transformation(origin = {-24, -8}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.StateGraph.TransitionWithSignal t2 annotation(
    Placement(visible = true, transformation(origin = {12, 26}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.StateGraph.TransitionWithSignal t1 annotation(
    Placement(visible = true, transformation(origin = {-54, 26}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput sig_battery_on annotation(
    Placement(visible = true, transformation(origin = {-84, -26}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-110, 2.22045e-16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.And and1 annotation(
    Placement(visible = true, transformation(origin = {50, -26}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
equation
  connect(error.active, s_error) annotation(
    Line(points = {{84, 17.2}, {84, 8.2}}, color = {255, 0, 255}));
  connect(BatteryON.outPort[2], t2.inPort) annotation(
    Line(points = {{-7.6, 26}, {8.4, 26}}));
  connect(not1.y, t5.condition) annotation(
    Line(points = {{-41.6, -26}, {-39.6, -26}, {-39.6, 62}}, color = {255, 0, 255}));
  connect(collectedReached.outPort[1], t3.inPort) annotation(
    Line(points = {{44.4, 26}, {58.4, 26}}));
  connect(BatteryOff.outPort[1], t1.inPort) annotation(
    Line(points = {{-65.6, 26}, {-58.6, 26}}));
  connect(BatteryON.outPort[1], t5.inPort) annotation(
    Line(points = {{-7.6, 26}, {-0.6, 26}, {-0.6, 74}, {-36, 74}}));
  connect(t5.outPort, BatteryOff.inPort[1]) annotation(
    Line(points = {{-41.5, 74}, {-89.75, 74}, {-89.75, 26}, {-83, 26}}));
  connect(BatteryON.active, s_batteryOn) annotation(
    Line(points = {{-16, 17.2}, {-16, 5.2}}, color = {255, 0, 255}));
  connect(t4.outPort, BatteryON.inPort[2]) annotation(
    Line(points = {{-25.5, -8}, {-35.5, -8}, {-35.5, 26}, {-23.5, 26}}));
  connect(t2.outPort, collectedReached.inPort[1]) annotation(
    Line(points = {{13.8, 26}, {27.8, 26}}));
  connect(BatteryOff.active, s_batteryOff) annotation(
    Line(points = {{-74, 17.2}, {-74, 5.2}}, color = {255, 0, 255}));
  connect(t1.outPort, BatteryON.inPort[1]) annotation(
    Line(points = {{-52.2, 26}, {-25.4, 26}}));
  connect(collectedReached.outPort[2], t4.inPort) annotation(
    Line(points = {{44.4, 26}, {52.4, 26}, {52.4, -8}, {-19.6, -8}}));
  connect(t3.outPort, error.inPort[1]) annotation(
    Line(points = {{63.8, 26}, {75.8, 26}}));
  connect(collectedReached.active, timer.u) annotation(
    Line(points = {{36, 17.2}, {36, 9.2}, {42, 9.2}}, color = {255, 0, 255}));
  connect(sig_centralhub_processed, t4.condition) annotation(
    Line(points = {{-24, -68}, {-24, -20}}, color = {255, 0, 255}));
  connect(sig_sensor_collected, t2.condition) annotation(
    Line(points = {{12, -68}, {12, 12}}, color = {255, 0, 255}));
  connect(sig_battery_on, not1.u) annotation(
    Line(points = {{-84, -26}, {-50, -26}}, color = {255, 0, 255}));
  connect(SetBoolean1.y, and1.u2) annotation(
    Line(points = {{32.9, -31}, {42.9, -31}}, color = {255, 0, 255}));
  connect(not1.y, and1.u1) annotation(
    Line(points = {{-41.6, -26}, {43.4, -26}}, color = {255, 0, 255}));
  connect(and1.y, t3.condition) annotation(
    Line(points = {{56.6, -26}, {61.6, -26}, {61.6, 12}}, color = {255, 0, 255}));
  connect(sig_battery_on, t1.condition) annotation(
    Line(points = {{-84, -26}, {-54, -26}, {-54, 12}}, color = {255, 0, 255}));
  connect(collectedReached.active, s_collectedReached) annotation(
    Line(points = {{36, 17.2}, {36, -2.8}}, color = {255, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Text(origin = {-3, -62}, extent = {{-33, 36}, {33, -36}}, textString = "%name"), Ellipse(origin = {3, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{79, -36}, {-79, 36}}), Ellipse(origin = {0, 3}, fillPattern = FillPattern.Solid, extent = {{100, -47}, {-100, 47}}), Ellipse(origin = {0, 3}, extent = {{100, -47}, {-100, 47}}), Ellipse(origin = {5, 0}, fillPattern = FillPattern.Solid, extent = {{25, -34}, {-25, 34}}), Ellipse(origin = {0, 3}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{96, -43}, {-96, 43}}), Ellipse(origin = {5, 0}, fillPattern = FillPattern.Solid, extent = {{25, -34}, {-25, 34}})}));
end CollectedProcessedObsFinal;
