block Sensor
  Modelica.Blocks.Interfaces.RealInput measurement annotation(
    Placement(visible = true, transformation(origin = {-119, -3}, extent = {{-19, -19}, {19, 19}}, rotation = 0), iconTransformation(origin = {-72, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  parameter Real HighRisk0_lb, HighRisk0_ub;
  parameter Real MidRisk0_lb, MidRisk0_ub;
  parameter Real LowRisk_lb, LowRisk_ub;
  parameter Real MidRisk1_lb, MidRisk1_ub;
  parameter Real HighRisk1_lb, HighRisk1_ub;
  parameter Real LowRisk_lb_pct, LowRisk_ub_pct;
  parameter Real MidRisk0_lb_pct, MidRisk0_ub_pct;
  parameter Real HighRisk0_lb_pct, HighRisk0_ub_pct;
  parameter Real recharge_level = 0.1;
  parameter Integer battery_gain = 40000;
  parameter Real threshold_transfer_failure = 0.1;
  Modelica.Blocks.Interfaces.BooleanInput context annotation(
    Placement(visible = true, transformation(origin = {-112, -52}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-69, -53}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Frequency annotation(
    Placement(visible = true, transformation(origin = {-110, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-69, -33}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Battery battery(gain_k = battery_gain, recharge_level = recharge_level)  annotation(
    Placement(visible = true, transformation(origin = {-17, -69}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  Modelica.Blocks.Logical.And and11 annotation(
    Placement(visible = true, transformation(origin = {-84, -52}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput Recharge annotation(
    Placement(visible = true, transformation(origin = {16, -100}, extent = {{-12, -12}, {12, 12}}, rotation = 90), iconTransformation(origin = {1.33227e-15, -68}, extent = {{-8, -8}, {8, 8}}, rotation = 90)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_battery_on annotation(
    Placement(visible = true, transformation(origin = {-52, -100}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {64, -48}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or1 annotation(
    Placement(visible = true, transformation(origin = {18, -54}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_collected(start = false) annotation(
    Placement(visible = true, transformation(origin = {110, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {64, -36}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  DataCollect dataCollect annotation(
    Placement(visible = true, transformation(origin = {-55, -3}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  Transition t1 annotation(
    Placement(visible = true, transformation(origin = {-26, -2}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_processed(start = false) annotation(
    Placement(visible = true, transformation(origin = {110, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {64, -26}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  DataProcess dataProcess(HighRisk0_lb = HighRisk0_lb, HighRisk0_lb_pct = HighRisk0_lb_pct, HighRisk0_ub = HighRisk0_ub, HighRisk0_ub_pct = HighRisk0_ub_pct, HighRisk1_lb = HighRisk1_lb, HighRisk1_ub = HighRisk1_ub, LowRisk_lb = LowRisk_lb, LowRisk_lb_pct = LowRisk_lb_pct, LowRisk_ub = LowRisk_ub, LowRisk_ub_pct = LowRisk_ub_pct, MidRisk0_lb = MidRisk0_lb, MidRisk0_lb_pct = MidRisk0_lb_pct, MidRisk0_ub = MidRisk0_ub, MidRisk0_ub_pct = MidRisk0_ub_pct, MidRisk1_lb = MidRisk1_lb, MidRisk1_ub = MidRisk1_ub, delayMax = 1)  annotation(
    Placement(visible = true, transformation(origin = {-2.22045e-16, 2.22045e-16}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  Transition t2 annotation(
    Placement(visible = true, transformation(origin = {30, -2}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  Transfer dataTransfer annotation(
    Placement(visible = true, transformation(origin = {55, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_transfered(start = false) annotation(
    Placement(visible = true, transformation(origin = {110, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {64, -16}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or2 annotation(
    Placement(visible = true, transformation(origin = {54, -34}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealOutput risk_pct annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {72, 6}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Transition t3 annotation(
    Placement(visible = true, transformation(origin = {84, -2}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput battery_charge annotation(
    Placement(visible = true, transformation(origin = {-92, -84}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {65, 55}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
equation
  sig_collected = dataCollect.sig_collected;
  sig_processed = dataProcess.sig_processed;
  sig_transfered = t3.sig_transition_out;
//and13.y;
//
  connect(context, and11.u1) annotation(
    Line(points = {{-112, -52}, {-91, -52}}, color = {255, 0, 255}));
  connect(Recharge, battery.recharge) annotation(
    Line(points = {{16, -100}, {16, -72}, {3, -72}}, color = {255, 0, 255}));
  connect(or1.y, battery.u) annotation(
    Line(points = {{18, -61}, {18, -66}, {3, -66}}, color = {255, 0, 255}));
  connect(battery.SIG_BATTERY_ON, sig_battery_on) annotation(
    Line(points = {{-38, -68}, {-52, -68}, {-52, -100}}, color = {255, 0, 255}));
  connect(measurement, dataCollect.measurement) annotation(
    Line(points = {{-119, -3}, {-67, -3}}, color = {0, 0, 127}));
  connect(Frequency, dataCollect.Frequency) annotation(
    Line(points = {{-110, -28}, {-90, -28}, {-90, -9}, {-67, -9}}, color = {0, 0, 127}));
  connect(and11.y, dataCollect.sensor_up) annotation(
    Line(points = {{-77, -52}, {-70, -52}, {-70, -12}, {-67, -12}}, color = {255, 0, 255}));
  connect(battery.SIG_BATTERY_ON, and11.u2) annotation(
    Line(points = {{-38, -68}, {-98, -68}, {-98, -57}, {-91, -57}}, color = {255, 0, 255}));
  connect(dataCollect.y, t1.measurement) annotation(
    Line(points = {{-42, 1}, {-35, 1}, {-35, 2}, {-29, 2}}, color = {0, 0, 127}));
  connect(dataCollect.sig_collected, t1.sig_transition_in) annotation(
    Line(points = {{-43, -7}, {-35.5, -7}, {-35.5, -5}, {-29, -5}}, color = {255, 0, 255}));
  connect(and11.y, t1.sensor_up) annotation(
    Line(points = {{-78, -52}, {-34, -52}, {-34, -10}, {-29, -10}}, color = {255, 0, 255}));
  connect(dataCollect.sig_collected, or1.u2) annotation(
    Line(points = {{-43, -7}, {-38, -7}, {-38, -47}, {13, -47}}, color = {255, 0, 255}));
  connect(t1.y, dataProcess.u) annotation(
    Line(points = {{-24, 0}, {-14, 0}}, color = {0, 0, 127}));
  connect(t1.sig_transition_out, dataProcess.sig_collected) annotation(
    Line(points = {{-24, -8}, {-14, -8}}, color = {255, 0, 255}));
  connect(t1.y, dataProcess.u) annotation(
    Line(points = {{-24, 0}, {-12, 0}}, color = {0, 0, 127}));
  connect(t1.sig_transition_out, dataProcess.sig_collected) annotation(
    Line(points = {{-24, -8}, {-12, -8}}, color = {255, 0, 255}));
  connect(dataProcess.y, t2.measurement) annotation(
    Line(points = {{11, 0}, {22, 0}, {22, 1}, {27, 1}}, color = {0, 0, 127}));
  connect(dataProcess.sig_processed, t2.sig_transition_in) annotation(
    Line(points = {{11, -8}, {27, -8}, {27, -7}}, color = {255, 0, 255}));
  connect(and11.y, t2.sensor_up) annotation(
    Line(points = {{-78, -52}, {-34, -52}, {-34, -18}, {20, -18}, {20, -10}, {27, -10}}, color = {255, 0, 255}));
  connect(t2.y, dataTransfer.u) annotation(
    Line(points = {{32, 0}, {44, 0}}, color = {0, 0, 127}));
  connect(t2.sig_transition_out, dataTransfer.sig_processed) annotation(
    Line(points = {{32, -8}, {44, -8}}, color = {255, 0, 255}));
  connect(dataProcess.sig_processed, or2.u2) annotation(
    Line(points = {{12, -8}, {16, -8}, {16, -24}, {50, -24}, {50, -26}}, color = {255, 0, 255}));
  connect(or2.y, or1.u1) annotation(
    Line(points = {{54, -40}, {54, -44}, {18, -44}, {18, -46}}, color = {255, 0, 255}));
  connect(dataTransfer.sig_transfered, or2.u1) annotation(
    Line(points = {{66, -8}, {70, -8}, {70, -24}, {54, -24}, {54, -26}}, color = {255, 0, 255}));
  connect(dataTransfer.y, t3.measurement) annotation(
    Line(points = {{66, 0}, {80, 0}}, color = {0, 0, 127}));
  connect(t3.y, risk_pct) annotation(
    Line(points = {{86, 0}, {110, 0}}, color = {0, 0, 127}));
  connect(dataTransfer.sig_transfered, t3.sig_transition_in) annotation(
    Line(points = {{66, -8}, {82, -8}, {82, -6}}, color = {255, 0, 255}));
  connect(and11.y, t3.sensor_up) annotation(
    Line(points = {{-78, -52}, {-34, -52}, {-34, -18}, {76, -18}, {76, -10}, {82, -10}}, color = {255, 0, 255}));
  connect(battery.battery_charge, battery_charge) annotation(
    Line(points = {{-34, -62}, {-74, -62}, {-74, -84}, {-92, -84}}, color = {0, 0, 127}));
protected
  annotation(
    Icon(graphics = {Rectangle(fillColor = {0, 170, 0}, fillPattern = FillPattern.Solid, extent = {{-60, 60}, {60, -60}}), Text(origin = {-2, 2}, rotation = -90, textColor = {255, 255, 255}, extent = {{52, -20}, {-52, 20}}, textString = "%name")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    uses(Modelica(version = "4.0.0")),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end Sensor;
