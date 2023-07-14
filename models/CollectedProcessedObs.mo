block CollectedProcessedObs
  Modelica.Blocks.Interfaces.BooleanOutput s_collectedReached annotation(
    Placement(visible = true, transformation(origin = {-14, -18}, extent = {{-4, -4}, {4, 4}}, rotation = -90), iconTransformation(origin = {109, 9}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput s_error annotation(
    Placement(visible = true, transformation(origin = {56, -6}, extent = {{-4, -4}, {4, 4}}, rotation = -90), iconTransformation(origin = {109, -9}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput sig_sensor_collected annotation(
    Placement(visible = true, transformation(origin = {-20, -32}, extent = {{-12, -12}, {12, 12}}, rotation = 90), iconTransformation(origin = {-110, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput sig_centralhub_processed annotation(
    Placement(visible = true, transformation(origin = {-20, 82}, extent = {{12, -12}, {-12, 12}}, rotation = 90), iconTransformation(origin = {-110, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot annotation(
    Placement(visible = true, transformation(origin = {50, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.StepWithSignal collectedReached(nIn = 1, nOut = 2) annotation(
    Placement(visible = true, transformation(origin = {4, 12}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.StateGraph.TransitionWithSignal t2 annotation(
    Placement(visible = true, transformation(origin = {-20, 12}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.StateGraph.TransitionWithSignal t4 annotation(
    Placement(visible = true, transformation(origin = {-20, 52}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanExpression SetBoolean1(y = timer.y > 2) annotation(
    Placement(visible = true, transformation(origin = {13, -36}, extent = {{-9, -6}, {9, 6}}, rotation = 0)));
  Modelica.StateGraph.StepWithSignal error(nIn = 1, nOut = 0) annotation(
    Placement(visible = true, transformation(origin = {56, 12}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.StateGraph.InitialStepWithSignal Initial(nIn = 1, nOut = 1) annotation(
    Placement(visible = true, transformation(origin = {-48, 12}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.StateGraph.TransitionWithSignal t3 annotation(
    Placement(visible = true, transformation(origin = {30, 12}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Blocks.Logical.Timer timer annotation(
    Placement(visible = true, transformation(origin = {12, -26}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
equation
  connect(collectedReached.active, timer.u) annotation(
    Line(points = {{4, 4}, {4, -26}, {7, -26}}, color = {255, 0, 255}));
  connect(SetBoolean1.y, t3.condition) annotation(
    Line(points = {{23, -36}, {30, -36}, {30, -2}}, color = {255, 0, 255}));
  connect(error.active, s_error) annotation(
    Line(points = {{56, 4}, {56, -6}}, color = {255, 0, 255}));
  connect(collectedReached.outPort[1], t3.inPort) annotation(
    Line(points = {{12, 12}, {26, 12}}));
  connect(sig_centralhub_processed, t4.condition) annotation(
    Line(points = {{-20, 82}, {-20, 64}}, color = {255, 0, 255}));
  connect(collectedReached.outPort[2], t4.inPort) annotation(
    Line(points = {{12, 12}, {18, 12}, {18, 52}, {-16, 52}}));
  connect(t4.outPort, Initial.inPort[1]) annotation(
    Line(points = {{-21.5, 52}, {-66, 52}, {-66, 12}, {-56, 12}}));
  connect(sig_sensor_collected, t2.condition) annotation(
    Line(points = {{-20, -32}, {-20, -2}}, color = {255, 0, 255}));
  connect(collectedReached.active, s_collectedReached) annotation(
    Line(points = {{4, 4}, {4, -6}, {-14, -6}, {-14, -18}}, color = {255, 0, 255}));
  connect(Initial.outPort[1], t2.inPort) annotation(
    Line(points = {{-40, 12}, {-24, 12}}));
  connect(t2.outPort, collectedReached.inPort[1]) annotation(
    Line(points = {{-18, 12}, {-4, 12}}));
  connect(t3.outPort, error.inPort[1]) annotation(
    Line(points = {{32, 12}, {48, 12}}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Text(origin = {-3, -62}, extent = {{-33, 36}, {33, -36}}, textString = "%name"), Ellipse(origin = {3, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{79, -36}, {-79, 36}}), Ellipse(origin = {0, 3}, fillPattern = FillPattern.Solid, extent = {{100, -47}, {-100, 47}}), Ellipse(origin = {0, 3}, extent = {{100, -47}, {-100, 47}}), Ellipse(origin = {5, 0}, fillPattern = FillPattern.Solid, extent = {{25, -34}, {-25, 34}}), Ellipse(origin = {0, 3}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{96, -43}, {-96, 43}}), Ellipse(origin = {5, 0}, fillPattern = FillPattern.Solid, extent = {{25, -34}, {-25, 34}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end CollectedProcessedObs;
